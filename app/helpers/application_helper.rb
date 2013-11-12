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
end
