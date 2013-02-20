desc "Reset TocTicket DataBase"
namespace :tocticket do
  task :db_setup do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end