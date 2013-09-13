set :thin_servers, 1
set :thin_port, 3000
server "192.168.10.200", :app, :web, :db, :primary => true
set :repository,  "git@labs.lebrijo.com:#{application}.git"