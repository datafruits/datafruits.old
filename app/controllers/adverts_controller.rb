class AdvertsController < ApplicationController
  before_action :set_advert, only: [:show, :edit, :update, :destroy]

  # GET /adverts
  def index
    @adverts = Advert.all
  end

  # GET /adverts/1
  def show
  end

  # GET /adverts/new
  def new
    @advert = Advert.new
  end

  # GET /adverts/1/edit
  def edit
  end

  # POST /adverts
  def create
    @advert = Advert.new(advert_params)

    if @advert.save
      redirect_to @advert, notice: 'Advert was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /adverts/1
  def update
    if @advert.update(advert_params)
      redirect_to @advert, notice: 'Advert was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /adverts/1
  def destroy
    @advert.destroy
    redirect_to adverts_url, notice: 'Advert was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advert
      @advert = Advert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def advert_params
      params[:advert]
    end
end
