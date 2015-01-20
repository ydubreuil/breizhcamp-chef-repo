#
# Cookbook Name:: breizhcamp-router
# Recipe:: dhcp
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

node.default[:dhcp][:interfaces] = [ 'br-local' ]
node.default[:dhcp][:use_bags] = false
node.default[:dhcp][:options]['domain-name-servers'] = '192.168.16.1'
node.default[:dhcp][:options]['domain-name'] = 'priv'

include_recipe 'dhcp::server'
dhcp_subnet '192.168.16.0' do
  range '192.168.16.100 192.168.31.200'
  netmask '255.255.240.0'
  broadcast '192.168.31.255'
  routers  [ '192.168.16.1' ]
end

