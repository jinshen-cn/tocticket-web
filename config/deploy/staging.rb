set :thin_servers, 1
set :thin_port, 3006
server "labs.lebrijo.com", :app, :web, :db, :primary => true
set :repository,  "git@labs.lebrijo.com:#{application}.git"

set :database_username, 'pg_user'
set :database_password, '12@tr%'
set :database_name, 'tocticket'
