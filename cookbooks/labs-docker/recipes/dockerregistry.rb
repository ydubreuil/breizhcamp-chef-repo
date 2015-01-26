#
# Cookbook Name:: labs-docker
# Recipe:: default
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
node.default['docker']['dns'] = '192.168.16.1'

include_recipe 'docker'

directory '/srv/docker/registry' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/srv/docker/registry.yml' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

docker_container 'registry' do
  detach true
  tty true
  port '5000:5000'
  env [
    'DOCKER_REGISTRY_CONFIG=/srv/docker/registry.yml',
    'SETTINGS_FLAVOR=local']
  volume '/srv/docker:/srv/docker'
end

cookbook_file '/srv/docker/registry-mirror.yml' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

docker_container 'registry' do
  container_name 'registry-mirror'
  detach true
  tty true
  port '5001:5000'
  env [
    'DOCKER_REGISTRY_CONFIG=/srv/docker/registry-mirror.yml',
    'SETTINGS_FLAVOR=local']
  volume '/srv/docker:/srv/docker'
end

