# breizhcamp-cookbooks

Collection of cookbook used to configure BreizhCamp and side infrastructures

## getting started

	bundle install


## install a new node

2 options
* git clone this repository on the machine and launch chef.sh

	./chef.sh -r 'recipe[apache2]'

* use knife zero to bootstrap as if you were using a chef server

    knife zero bootstrap NODE_NAME_OR_IP --sudo -x admin -r 'role[dockerlab-server]'

## useful commands

* add a cookbook to the repository

	knife cookbook site install COOKBOOK_NAME

