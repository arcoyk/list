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
  	@stroke = Stroke.new
  	@stroke.tags = params[:stroke][:tags]
  	@stroke.content = params[:stroke][:content]
    @stroke.like = 0
    @stroke.icon = "default.png"
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


end
