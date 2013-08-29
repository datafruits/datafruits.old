class PodcastsController < ApplicationController
  load_and_authorize_resource
  def index
    @podcast = Podcast.all
    respond_to do |format|
      format.html
      format.xml
    end
  end
  def show

  end
  def new

  end
  def create
    respond_to do |format|
      if @podcast.save
        format.html { redirect_to @podcast, notice: 'Podcast was successfully created.' }
        format.json { render json: @podcast, status: :created, location: @podcast }
      else
        format.html { render action: 'new' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit

  end
  def update
  end
  def destroy

  end
  private
  def podcast_params
    params.require(:podcast).permit(:user_id, :mp3, :description, :title)
  end
end
