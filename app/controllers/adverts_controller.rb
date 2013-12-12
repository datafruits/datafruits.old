class AdvertsController < ApplicationController
  load_and_authorize_resource

  # GET /adverts
  def index
  end

  # GET /adverts/1
  def show
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advert }
    end
  end
  def create
    respond_to do |format|
      if @advert.save
        format.html { redirect_to @advert, notice: 'Advert was successfully created.' }
        format.json { render json: @advert, status: :created, location: @advert }
      else
        format.html { render action: 'new' }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit

  end
  def update
    respond_to do |format|
      if @advert.update_attributes(advert_params)
        format.html { redirect_to @advert, notice: 'Advert was successfully created.' }
        format.json { render json: @advert, status: :created, location: @advert }
      else
        format.html { render action: 'new' }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @advert.destroy

    respond_to do |format|
      format.html { redirect_to adverts_url }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def advert_params
      params.require(:advert).permit(:title, :mp3_url)
    end
end
