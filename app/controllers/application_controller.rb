class ApplicationController < ActionController::Base
  protect_from_forgery

  around_filter :set_time_zone

  # params for cancan and devise
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  before_filter :configure_devise_parameters, if: :devise_controller?

  def metadata
    song = HTTParty.get "http://radio.datafruits.fm/currentsong"
    respond_to do |format|
      format.json {
        render :json => {:currentsong => song}
      }
    end
  end

  def chatroom
    respond_to do |format|
      format.html { render "layouts/chatroom" }
    end
  end

  def playlist
    podcasts = Podcast.last(10)
    adverts = Advert.last(2).cycle.take(podcasts.length)
    @tracks = podcasts.zip(adverts).flatten
    logger.info @tracks.length
    respond_to do |format|
      format.text { render "layouts/playlist" }
    end
  end

  def data_dayz_sign_up
    authorize! :create, Show
    @slots = []
    (0..20).step(2) do |n|
      start = Time.utc(2013,11,22,n).in_time_zone
      finish = Time.utc(2013,11,22,n+2).in_time_zone
      show = Show.where(time: start, end_time: finish).first
      if show
        @slots << show
      else
        @slots << Show.new(time: start, end_time: finish)
      end
    end
    (0..20).step(2) do |n|
      start = Time.utc(2013,11,23,n).in_time_zone
      finish = Time.utc(2013,11,23,n+2).in_time_zone
      show = Show.where(time: start, end_time: finish).first
      if show
        @slots << show
      else
        @slots << Show.new(time: start, end_time: finish)
      end
    end

    respond_to do |format|
      format.html { render "layouts/data_dayz_sign_up" }
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    render_error 404, exception
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

  def set_time_zone(&block)
    if current_user
      Time.use_zone(current_user.time_zone, &block)
    elsif browser_timezone.present?
      Time.use_zone(browser_timezone, &block)
    else
      yield
    end
  end

  def browser_timezone
    cookies["browser.timezone"]
  end

  protected
  def configure_devise_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation,
                                                           :remember_me, :password_hash, :password_salt,
                                                           :username, :role, :avatar, :login, :role_ids,
                                                           :time_zone) }
  end
end
