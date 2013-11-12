module ApplicationHelper
  def html_pipeline(text)
    context = {
      :asset_root => "/images/",
      :gfm => false
    }
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter
    ], context
    result = pipeline.call(text)
    result[:output].to_s.html_safe
  end

  def next_scheduled_show
    show = Show.where("time >= ?", Time.current).order("time ASC").first
  end

  def multiple_timezones(time)
    timezones = {"PST" => "Pacific Time (US & Canada)",
                 "EST" => "Eastern Time (US & Canada)",
                 "UK"  => "London",
                 "EU"  => "Stockholm",
                 "日本"=> "Tokyo"}
    time_string = ""

    timezones.each do |k,v|
      time_string << "[#{Time.zone.parse(time.to_s).in_time_zone(v).strftime("%H:%M")} #{k}] "
    end

    time_string
  end
end
