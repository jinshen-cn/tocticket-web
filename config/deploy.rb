# Multistaging
set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# Application
set :application, "gogetix"
set :scm, :git
set :repository,  "git@labs.lebrijo.com:gogetix-web.git"
server "gogetix.com", :app, :web, :db, :primary => true

set :user, "root"
set :user_sudo, false
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