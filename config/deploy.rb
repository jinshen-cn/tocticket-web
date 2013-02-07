# Multistaging
set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# Application
set :application, "gogetix"
set :scm, :git
set :repository,  "git@labs.lebrijo.com:gogetix-web.git"
server "gogetix.com", :app, :web, :db, :primary => true
set(:deploy_to) {"/var/www/#{application}/#{stage}"} # This makes lazy the load
set(:rake_command) {"cd #{current_path} && bundle exec rake RAILS_ENV=#{stage}"}

# Thin
set :thin_config_path, "/etc/thin"
set(:thin_config_file) {"#{thin_config_path}/#{application}-#{stage}.yml"}

## rvm
set :rvm_ruby_string, 'ruby-1.9.3-p327@gogetix-web'
set :rvm_type, :system
require "rvm/capistrano"

require "bundler/capistrano"

set :user, "root"
set :user_sudo, false


namespace :thin do
  desc "Sets up Thin server environments"
  task :setup, :roles => :app do
    invoke_command "thin config -C #{thin_config_file} -c #{current_path} -e #{stage} --servers #{thin_servers} --port #{thin_port}"
  end
end

namespace :db do
  desc "Set up the database: create, migrate and seed"
  task :setup, :roles => :db do
    run "#{rake_command} db:drop"
    run "#{rake_command} db:create"
    run "#{rake_command} db:migrate"
    run "#{rake_command} db:seed"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  desc "Precompile all application assets"
  task :precompile_assets, :roles => :app do
    run "#{rake_command} assets:clean"
    run "#{rake_command} assets:precompile"
  end
  desc "Stop server"
  task :stop, :roles => :app do

    invoke_command "service thin stop"
  end

  desc "Start server"
  task :start, :roles => :app do

    invoke_command "service thin start"
  end

  # Need to define this restart ALSO as 'cap deploy' uses it
  # (Gautam) I dont know how to call tasks within tasks.
  desc "Restart server"
  task :restart, :roles => :app do

    invoke_command "service thin stop"
    invoke_command "service thin start"
  end
end