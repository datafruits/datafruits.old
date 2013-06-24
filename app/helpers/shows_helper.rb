module ShowsHelper
  def link_to_show(show)
    if !show.title.blank?
      link_to "#{show.title} - #{show.time.strftime("%A %H:%M %Z")}", show 
    else
      link_to "#{show.user.username} - #{show.time.strftime("%A %H:%M %Z")}", show
    end
  end
end
