class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile

  around_filter :set_time_zone

  before_filter :set_locale

  layout :determine_layout

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
    @slots = data_dayz_slots

    if current_user
      @confirm = "Sign up for this slot?"
    else
      @confirm = "You must be logged in to sign up for a slot!"
    end

    respond_to do |format|
      format.html { render "layouts/data_dayz_sign_up" }
    end
  end

  def data_dayz
    @slots = data_dayz_slots
    @slots.select!{ |s| s.persisted? }
    @lineup = @slots.map{|m| m.user }.uniq
    @guest_mixes = @slots.select{|s| !s.guests.blank?}.map(&:guests).uniq.map{|m| m.gsub!(/guest mix by /i,'')}
    respond_to do |format|
      format.html { render "/layouts/data_dayz", layout: false }
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    render_error 404, exception
  end

  private

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    if request.env['HTTP_ACCEPT_LANGUAGE']
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end

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

  def data_dayz_slots
    slots = []
    (0..20).step(2) do |n|
      start = Time.utc(2013,11,22,n).in_time_zone
      finish = Time.utc(2013,11,22,n+2).in_time_zone
      show = Show.where(time: start, end_time: finish).first
      if show
        slots << show
      else
        slots << Show.new(time: start, end_time: finish)
      end
    end
    (0..20).step(2) do |n|
      start = Time.utc(2013,11,23,n).in_time_zone
      finish = Time.utc(2013,11,23,n+2).in_time_zone
      show = Show.where(time: start, end_time: finish).first
      if show
        slots << show
      else
        slots << Show.new(time: start, end_time: finish)
      end
    end
    slots
  end

  def determine_layout
    if request.headers['X-PJAX']
      false
    else
      'application'
    end
  end
end
