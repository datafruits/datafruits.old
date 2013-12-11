class PodcastsController < ApplicationController
  load_and_authorize_resource
  def index
    @podcast = Podcast.all.order('pub_date DESC')
    respond_to do |format|
      format.html
      format.xml
    end
  end
  def show

  end
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @podcast }
    end
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
    respond_to do |format|
      if @podcast.update_attributes(podcast_params)
        format.html { redirect_to @podcast, notice: 'Podcast was successfully created.' }
        format.json { render json: @podcast, status: :created, location: @podcast }
      else
        format.html { render action: 'new' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end
  private
  def podcast_params
    params.require(:podcast).permit(:user_id, :mp3, :description, :title, :pub_date, :mp3_url)
  end
end
