# Multistaging
set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# Application
set :application, "tocticket"
set :scm, :git
set :repository,  "git@labs.lebrijo.com:gogetix-web.git"
server "lebrijo.com", :app, :web, :db, :primary => true
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

namespace :app do
  desc "Setup or reset: DB and App_server"
  task :setup, :roles => :app do
    deploy.stop
    rvm.install_ruby
    deploy.setup
    deploy.check
    deploy.update
    thin.setup
    db.setup
    deploy.precompile_assets
    thin.start
  end
  desc "Update from last release: DB and App_server"
  task :update, :roles => :ap do
    deploy.update
    deploy.migrate
    deploy.precompile_assets
    thin.restart
  end
end

namespace :thin do
  desc "Sets up Thin server environments"
  task :setup, :roles => :app do
    invoke_command "thin config -C #{thin_config_file} -c #{current_path} -e #{stage} --servers #{thin_servers} --port #{thin_port}"
  end
  desc "Start server"
  task :start, :roles => :app do
    invoke_command "cd #{current_path} && thin start -C #{thin_config_file}"
  end
  desc "Stop server"
  task :stop, :roles => :app do
    invoke_command "cd #{current_path} && thin stop -C #{thin_config_file}"
  end
  desc "Restart server"
  task :restart, :roles => :app do
    stop
    start
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
end