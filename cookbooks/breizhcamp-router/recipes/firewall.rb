#
# Cookbook Name:: breizhcamp-router
# Recipe:: firewall
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


node.default['iptables-ng']['script_ipv6'] = '/etc/iptables/rules.v6.disabled'

include_recipe 'iptables-ng'

iptables_ng_rule 'masquerade-br-local' do
  chain 'POSTROUTING'
  table 'nat'
  rule  '-s 192.168.16.0/20 ! -o br-local -j MASQUERADE'
  ip_version 4
end

iptables_ng_rule 'forward-local' do
  chain 'FORWARD'
  table 'filter'
  rule  '-o br-local -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT'
  ip_version 4
end

