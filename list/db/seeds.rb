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

@stroke = Stroke.new
@stroke.tags = "book, @meaue, romance"
@stroke.content = "Dreamers (1988) Albert Adair is a romance novel"
@stroke.icon = "img/default.png"
@stroke.url = "http://google.com"
@stroke.like = 344
@stroke.save

@stroke = Stroke.new
@stroke.tags = "movie, @meaue, SF"
@stroke.content = "One Point O (1999) is a SF film"
@stroke.icon = "img/default.png"
@stroke.url = "http://google.com"
@stroke.like = 435
@stroke.save

@stroke = Stroke.new
@stroke.tags = "book"
@stroke.content = "Moby Dick is a book"
@stroke.icon = "img/default.png"
@stroke.url = "http://google.com"
@stroke.like = 435
@stroke.save