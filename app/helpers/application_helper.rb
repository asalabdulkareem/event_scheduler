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
  
  def float_to_time(float)
    hours = float
    minutes = (float % 1) * 60
    time = sprintf("%d:%02d", hours, minutes)
    return time
  end
end
