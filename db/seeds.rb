# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'CREATING ROLES ...'
Role.create([
  { :name => 'organizer' },
  { :name => 'attendee' }
], :without_protection => true)

puts 'SETTING UP DEFAULT USERS LOGIN ...'

organizer = User.new :name => 'Organizer User', :email => 'organizer@tocticket.com', :password => 'please', :password_confirmation => 'please'
organizer.add_role :organizer
organizer.save
puts 'New Organizer created: ' << organizer.name

attendee = User.new :name => 'Attendee User', :email => 'attendee@tocticket.com', :password => 'please', :password_confirmation => 'please'
attendee.add_role :attendee
attendee.save
puts 'New Attendee created: ' << attendee.name

admin = AdminUser.create!(:email => 'admin@tocticket.com', :password => 'please', :password_confirmation => 'please')
puts 'New Admin created: ' <<  admin.email
