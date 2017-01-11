module ApplicationHelper
  # return 12-hour time format (eg 12:01 P.M.) from number of seconds into the day
  def seconds_to_12_hour_time(seconds)
    hours = seconds / 3600
    minutes = ((seconds % 3600) / 60)
    suffix = 'A.M.'
    
    if hours >= 12
      suffix = 'P.M.'
      
      if hours > 12
        hours -= 12
      end
    end
    
    time = sprintf("%d:%02d %s", hours, minutes, suffix)
    return time
  end
  
  # return duration formatted as hours:minutes given the number of hours as a float
  def float_to_time(float)
    hours = float
    minutes = (float % 1) * 60
    time = sprintf("%d:%02d", hours, minutes)
    return time
  end
  
  def generate_hour_options
    options = ''
    (8..20).step(0.5).each do |hours|
      seconds = (hours * 3600).to_i
      formatted = seconds_to_12_hour_time(seconds)
      options += "<option value=\"#{seconds}\">#{formatted}</option>\n"
    end
    
    return options
  end
  
end
