class StrokesController < ApplicationController
  def index
  	@strokes = Stroke.all
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
    params.delete :query
  end

  def toggle
    @stroke = Stroke.find(params[:id])
    if @stroke.mode == 1
      @stroke.mode = 0
    elsif mode == 0
      @stroke.mode = 1
    end
    redirect_to '/strokes/index'
  end

  def like
    @stroke = Stroke.find(params[:id])
    @stroke.like += 1
    puts @stroke
    if request.xhr?
      head :ok
    else
      redirect_to @stroke
    end
  end


end
