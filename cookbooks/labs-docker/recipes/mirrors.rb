#
# Cookbook Name:: labs-docker
# Recipe:: mirrors
#
# Copyright 2015, BreizhCamp
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'apache2'

%w(proxy proxy_http).each do |modulename|
  apache_module "#{modulename}" do
    enable true
  end
end

# it also contains HTTP reverse proxy for docker registry
web_app "mirror" do
  template 'mirror.conf.erb'
  server_name "#{node['hostname'] + '.priv'}"
  docroot '/srv/mirrors/www'
  directory_options [ 'Indexes', 'FollowSymLinks']
end

%w(/srv/mirrors/scripts
   /srv/mirrors/ubuntu-keyring
   /srv/mirrors/www/mirrors/archive.ubuntu.com/ubuntu
   /srv/mirrors/www/mirrors/updates.jenkins-ci.org/plugins
   /srv/mirrors/www/boot2docker).each do |dirname|
  directory "#{dirname}" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
  end
end

remote_file '/srv/mirrors/www/boot2docker/Boot2Docker-1.4.1.pkg' do
  source 'https://github.com/boot2docker/osx-installer/releases/download/v1.4.1/Boot2Docker-1.4.1.pkg'
  mode 644
  checksum 'c6e5b4a065dbdaab05948cef74b8ad3acc3c3ccddc8c4189dd396b310f8ca0e9'
end

remote_file '/srv/mirrors/www/boot2docker/docker-install.exe' do
  source 'https://github.com/boot2docker/windows-installer/releases/download/v1.4.1/docker-install.exe'
  mode 644
  checksum 'c786251284ba0dfd04533358a736891f5035c8fce02a622bbe1ab9e9c4c146b1'
end

include_recipe 'apt'

package 'debmirror' do
  action :install
end

%w(/srv/mirrors/scripts/mirror-jenkinsci.sh
   /srv/mirrors/scripts/mirror-ubuntu.sh).each do |scriptname|
  cookbook_file "#{scriptname}" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

cookbook_file '/srv/mirrors/ubuntu-keyring/trustedkeys.gpg' do
  mode 0644
  action :create
end

package 'jesred' do
  action :install
end

package 'squid' do
  action :install
end

service 'squid3' do
  service_name 'squid3'
  provider Chef::Provider::Service::Upstart
  supports [:start, :restart, :reload, :status]
  action :nothing
end

%w(/etc/jesred.acl
   /etc/jesred.conf
   /etc/jesred.rules
   /etc/squid3/squid.conf).each do |filename|
  cookbook_file "#{filename}" do
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    notifies :restart, 'service[squid3]', :delayed
  end
end

include_recipe 'iptables-ng'

iptables_ng_rule 'squid-transparent' do
  chain 'PREROUTING'
  table 'nat'
  rule '-i br-local -s 192.168.16.0/20 -p tcp --dport 80 -j REDIRECT --to-port 3129'
  ip_version 4
end


