file = File.open("film_list_a.txt")
file.each do |f|
	puts '@stroke = Stroke.new'
	puts '@stroke.tags = "movie"'
	puts '@stroke.content = "' + f.gsub(/\n/, '') + '"'
	puts '@stroke.icon = "default.png"'
	puts '@stroke.url = "http://google.com"'
	puts '@stroke.like = 0'
	puts '@stroke.save'
	puts ""
end
file.close

# @stroke = Stroke.new
# @stroke.tags = "movie, @meaue, SF"
# @stroke.content = "One Point O (1999) is a SF film"
# @stroke.icon = "default.png"
# @stroke.url = "http://google.com"
# @stroke.like = 435
# @stroke.save