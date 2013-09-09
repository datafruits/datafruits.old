module ShowsHelper
  def link_to_show(show)
    if !show.title.blank?
      link_to "#{show.title}", show 
    else
      link_to "#{show.user.username} - #{show.time.strftime("%A %H:%M %Z")}", show
    end
  end
  def link_to_show_with_time(show)
    link_to "#{show.time.strftime("%A %m/%d %H:%M %Z")}", show 
  end

  def tweet_text(show)
    "#{show.user.username} - #{show.title} on @datafruits #{show.time.strftime("%m/%d")} - #{multiple_timezones(show.time)}"
  end
end
