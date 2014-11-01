module ApplicationHelper

  def fix_url(str)
    str.start_with?('http://') ? str : "http://#{str}"
  end

  # def fix_datetime(dt)
    # if logged_in? and !current_user.time_zone.blank?
    #   dt = dt.in_time_zone(current_user.time_zone)
    # end
    # dt.strftime("%A %b %d %I:%M %P")
  def fix_datetime(item)  
    dt = item.sms_time.to_datetime.in_time_zone(item.time_zone_offset * -1)
    dt.strftime("%A %b %d %I:%M %P")
  end

end
