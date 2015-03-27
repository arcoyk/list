require "uri"
require "open-uri"
require "nokogiri"

class StrokesController < ApplicationController
  $stroke_limit = 100
  def index
  	@all_strokes = Stroke.where("tags = '@meaue'")
    @strokes = @all_strokes[0, $stroke_limit]
    @strokes = @strokes.sort {|a, b| b.like <=> a.like}
    @random_jumbotron_img = "jumbotron/" + rand(1..7).to_s + ".png"
  end

  def show
  end

  def new
  end

  def create
    stroke = Stroke.new
    comment = params[:stroke][:content]
    title = params[:stroke][:title]
    stroke.content = comment
    stroke.tags = params[:stroke][:tags]
    stroke.like = 0
    stroke.icon = "default.png"
    stroke.save
  end

  def search
    # @strokes = Stroke.where(['name LIKE ?', "meaue"])
    @all_strokes = Stroke.all
    @strokes = @all_strokes[0, $stroke_limit]
    @strokes = @strokes.select { |stroke| stroke.tags.index(simple_query)}
    @strokes = @strokes[0..$stroke_limit]
    @strokes = @strokes.sort {|a, b| b.like <=> a.like}
    params.delete :query
  end

  def push
    @stroke = Stroke.find(params[:id])
    @stroke.tags = @stroke.tags + ", @Meaue"
    @stroke.save
    redirect_to '/strokes/index'
  end

  def pull
    @stroke = Stroke.find(params[:id])
    @stroke.save
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

  def short_tags tags
    if tags.length > 10
      return tags.split("")[0, 10].join("") + "..."
    else
      return tags
    end
  end


end
