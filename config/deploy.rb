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

## rvm
set :rvm_ruby_string, 'ruby-1.9.3-p327@gogetix-web'
set :rvm_type, :system
require "rvm/capistrano"

set :user, "root"
set :user_sudo, false


namespace :thin do
  desc "Sets up Thin server environments"
  task :setup, :roles => :app do
    invoke_command "thin config -C /etc/thin/#{application}-#{stage}.yml -c #{deploy_to}/current -e #{stage} --servers #{thin_servers} --port #{thin_port}"
  end
end



# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  desc "Custom AceMoney deployment: stop."
  task :stop, :roles => :app do

    invoke_command "service thin stop"
  end

  desc "Custom AceMoney deployment: start."
  task :start, :roles => :app do

    invoke_command "service thin start"
  end

  # Need to define this restart ALSO as 'cap deploy' uses it
  # (Gautam) I dont know how to call tasks within tasks.
  desc "Custom AceMoney deployment: restart."
  task :restart, :roles => :app do

    invoke_command "service thin stop"
    invoke_command "service thin start"
  end
end