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
  	@stroke.save
  	redirect_to '/strokes/index'
  end

  def search
    # @strokes = Stroke.where(['name LIKE ?', "meaue"])
    @strokes = Stroke.where("content = ?", params[:query])
    params.delete :query
  end

end
