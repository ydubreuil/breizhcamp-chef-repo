#!/bin/bash

# Check whether a command exists - returns 0 if it does, 1 if it does not
exists() {
  if command -v $1 >/dev/null 2>&1
  then
    return 0
  else
    return 1
  fi
}

if ! exists chef-client ; then
  if ! exists wget ; then
    sudo apt-get install wget
  fi

  wget -O - https://www.chef.io/chef/install.sh | sudo bash
fi

sudo chef-client --local-mode "$@"

