#!/bin/bash

# Disable Strict Host checking for non interactive git clones

mkdir -p -m 0700 /root/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Setup git variables
if [ ! -z "$GIT_EMAIL" ]; then
 git config --global user.email "$GIT_EMAIL"
fi
if [ ! -z "$GIT_NAME" ]; then
 git config --global user.name "$GIT_NAME"
 git config --global push.default simple
fi

# Pull down code form git for our site!
if [ ! -z "$GIT_REPO" ]; then
  rm /var/www/*
  if [ ! -z "$GIT_BRANCH" ]; then
    git clone -b $GIT_BRANCH $GIT_REPO /var/www/
  else
    git clone $GIT_REPO /var/www/
  fi
fi

# Start the dancer process
pushd /var/www/
plackup -r bin/app.psgi --port 5000 --host 0.0.0.0
