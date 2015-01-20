#
# Cookbook Name:: breizhcamp-router
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

include_recipe 'network_interfaces'

# refactoring required !!!
network_interfaces 'eth0' do
  onboot true
end

network_interfaces 'eth1' do
  onboot true
end

network_interfaces 'br-local' do
  onboot true
  target '192.168.16.1'
  mask '255.255.240.0'
  bridge ['eth0', 'eth1']
end

include_recipe 'breizhcamp-router::dhcp'
include_recipe 'breizhcamp-router::dns'
include_recipe 'breizhcamp-router::firewall'

