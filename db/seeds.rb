# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'CREATING ROLES'
Role.create([
  { :name => 'admin' }, 
  { :name => 'organizer' }, 
  { :name => 'atendee' }
], :without_protection => true)
puts 'SETTING UP DEFAULT USER LOGIN'
admin = User.create! :name => 'Admin User', :email => 'admin@gogetix.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << admin.name
organizer = User.create! :name => 'Organizer User', :email => 'organizer@gogetix.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << organizer.name
attendee = User.create! :name => 'Attendee User', :email => 'attendee@gogetix.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << attendee.name
admin.add_role :admin
organizer.add_role :organizer
attendee.add_role :attendee
