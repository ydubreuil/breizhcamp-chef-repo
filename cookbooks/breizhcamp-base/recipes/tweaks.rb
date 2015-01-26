#
# Cookbook Name:: breizhcamp-base
# Recipe:: tweaks
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
# fight bufferbloat
node.default['sysctl']['params']['net']['core']['default_qdisc'] = 'fq_codel'

# disable ipv6
node.default['sysctl']['params']['net']['ipv6']['conf']['all']['disable_ipv6'] = 1

include_recipe 'sysctl::apply'

include_recipe 'apt'

package 'linux-hwe-generic-trusty' do
  action :install
end
