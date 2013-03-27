class ApplicationController < ActionController::Base
  protect_from_forgery

  def podcast
    @podcast = Nokogiri::XML(File.read("./public/podcast.xml"))
    @items = @podcast.xpath("//item").map do |m|
      { url: m.xpath("enclosure").first.get_attribute("url"), title: m.xpath("title").text }
    end.reverse
    respond_to do |format|
      format.html { render "layouts/podcast" }
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
end
