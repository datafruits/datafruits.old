class ApplicationController < ActionController::Base
  protect_from_forgery

  around_filter :set_time_zone

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def podcast
    @podcast = Nokogiri::XML(File.read("./public/podcast.xml"))
    @items = @podcast.xpath("//item").map do |m|
      { url: m.xpath("enclosure").first.get_attribute("url"), title: m.xpath("title").text }
    end.reverse
    respond_to do |format|
      format.html { render "layouts/podcast" }
    end
  end

  def metadata
    song = $redis.get "currentsong"
    respond_to do |format|
      format.json {
        render :json => {:currentsong => song}
      }
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
end
