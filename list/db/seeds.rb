# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user = User.new
@user.name = 'Yui Kita'
@user.username = 'Meaue'
@user.location = 'Tokyo, Japan'
@user.about = 'Yui is a hacker'
@user.save

@user = User.new
@user.name = 'Keisuke Igrashi'
@user.username = 'Rupin'
@user.location = 'Tokyo, Japan'
@user.about = 'Keisuke is a cook'
@user.save
