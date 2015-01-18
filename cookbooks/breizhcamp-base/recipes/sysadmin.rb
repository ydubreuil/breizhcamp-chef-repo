
include_recipe 'users::sysadmins'

node.default['authorization']['sudo']['passwordless'] = true
node.default['authorization']['sudo']['include_sudoers_d'] = true

include_recipe 'sudo'
