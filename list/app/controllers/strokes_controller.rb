require "uri"
require "open-uri"
require "nokogiri"

class StrokesController < ApplicationController
  def index
  	@strokes = Stroke.all
    @strokes = @strokes.sort {|a, b| b.like <=> a.like}
  end

  def show
  end

  def new
  end

  def create
    http_schema = /^(https?|ftp)(:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+)$/
  	@stroke = Stroke.new
  	@stroke.tags = params[:stroke][:tags]
  	@stroke.content = params[:stroke][:content]
    @stroke.icon = "default.png"
    @stroke.like = 0
    if @stroke.content.match http_schema
      @stroke.like = 100
      @stroke = self.auto_digest @stroke.content
    end
  	@stroke.save
  	redirect_to '/strokes/index'
  end

  def search
    # @strokes = Stroke.where(['name LIKE ?', "meaue"])
    tmp = Stroke.all
    simple_query = params[:query].first
    @strokes = tmp.select { |stroke| stroke.tags.index(simple_query)}
    @strokes = @strokes.sort {|a, b| b.like <=> a.like}
    params.delete :query
  end

  def push
    @stroke = Stroke.find(params[:id])
    @stroke.like += 1
    @stroke.save
    puts @stroke
    redirect_to '/strokes/index'
  end

  def pull
    @stroke = Stroke.find(params[:id])
    @stroke.like = 0
    @stroke.save
    puts @stroke
    redirect_to '/strokes/index'
  end

  def auto_tag str
    words = str.split(" ")
    words.sort! do |w1, w2|
      words.count(w1) <=> words.count(w2)
    end
    words.uniq!
    return words[0, 3]
  end

  def auto_digest url
    doc = Nokogiri::HTML open(url)
    title = doc.css("title")[0].children[0].text
    img_nodeset = doc.css("img")
    p_nodeset = doc.css("p")
    imgs = Array.new
    img_nodeset.each do |node|
      imgs.push node
    end
    imgs.sort! do |img1, img2|
      width1 = img1.attribute("width")
      width2 = img2.attribute("width")
      value1 = 0
      value2 = 0
      if width1 != nil
        value1 = width1.value.to_i
      end
      if width2 != nil
        value2 = width2.value.to_i
      end
      value1 <=> value2
    end
    text = ""
    p_nodeset.each do |node|
      node.children.each do |child|
        text += child.text
      end
    end
    tags = self.auto_tag(text)
    img_href = imgs.first
    stroke = Stroke.new
    stroke.content = title
    stroke.icon = imgs.first.attribute("src").value
    stroke.tags = tags.join(",")
    stroke.like = 0
    stroke.url = url
    return stroke
  end

end
