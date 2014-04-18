class ShowsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shows }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @show }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @show }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @show.save
        format.html { redirect_to @show, notice: 'Show was successfully created.' }
        format.json { render json: @show, status: :created, location: @show }
      else
        format.html { render action: "new" }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @show.update_attributes(show_params)
        format.html { redirect_to @show, notice: 'Show was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @show.destroy

    respond_to do |format|
      format.html { redirect_to shows_url }
      format.json { head :no_content }
    end
  end

  private
  def show_params
    params.require(:show).permit(:time, :end_time, :title, :user_id, :description,
                                 :time_zone, :image)
  end
end
