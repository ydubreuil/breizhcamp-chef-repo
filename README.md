# breizhcamp-cookbooks

Collection of cookbook used to configure BreizhCamp and side infrastructures

## getting started

	bundle install

## useful commands

* add a cookbook to the repository

	knife cookbook site install COOKBOOK_NAME

* converge a node

	chef-client --local-mode --runlist 'recipe[apache2]'

