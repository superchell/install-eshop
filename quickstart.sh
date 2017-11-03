#!/usr/bin/env bash

#install bundler
if ! gem list bundler -i; then gem install bundler; fi
bundle install

#install Spree and run generator
echo 'install Spree...'
rails g spree:install --user_class=Spree::User --sample=false
rails g spree:auth:install
rails g spree_gateway:install

bundle exec rake railties:install:migrations
bundle exec rake db:migrate
bundle exec rake db:seed

#install CamaleonCms
echo 'install CamaleonCms...'
rails generate camaleon_cms:install
rake camaleon_cms:generate_migrations

#install Camaleon-spree
echo 'install Camaleon-spree...'
rake camaleon_cms:generate_migrations

#run migrations
rake db:migrate





