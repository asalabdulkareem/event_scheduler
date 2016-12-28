class AvailableTime < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  validates_presence_of :from
  validates_presence_of :to
  validate :start_time_not_after_end_time
  validate :start_and_end_time_aligned
  
  # return new AvailableTime on a specific day with offsets in seconds within that day
  DAYS = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
  def self.build_on_day(attributes = {})
    offset = (Time.now.beginning_of_week + DAYS.index(attributes[:day]) * 1.days).to_i
    attributes[:from] = Time.at(attributes[:from] + offset)
    attributes[:to] = Time.at(attributes[:to] + offset)
    attributes.delete(:day)
    return new(attributes)
  end
  
  # return new AvailableTime on a specific date with offsets in seconds within that date
  def self.build_on_date(attributes = {})
    offset = Date.parse(attributes[:date]).to_time.to_i
    attributes[:from] = Time.at(attributes[:from] + offset)
    attributes[:to] = Time.at(attributes[:to] + offset)
    attributes.delete(:date)
    return new(attributes)
  end
  
  # returns a hash with keys of the form [28800, 'Sunday'], [28800, 'Monday'], ...
  # where 28800 is the number of seconds since the beginning of the day and 'Sunday' is the day
  def self.lecture_timetable(available_times)
    timetable = Hash.new(false)
    available_times.each do |available_time|
      start = available_time.from
      week_offset = (start - start.beginning_of_week).to_i
      start = week_offset % 1.day
      day = DAYS[(week_offset / 1.day).to_i]
      
      _end = available_time.to
      week_offset = (_end - _end.beginning_of_week).to_i
      _end = week_offset % 1.day
      
      (start.._end - 1).each do |x|
        timetable[[x, day]] = true
      end
    end
    return timetable
  end
  
  # returns a hash with keys of the form [28800, <date>], [28800, <date>], ...
  # where 28800 is the number of seconds since the beginning of the day and <date> is the date
  def self.exam_timetable(available_times)
    timetable = Hash.new(false)
    available_times.each do |available_time|
      date = available_time.from.to_date
      start = available_time.from.to_i % 1.day
      _end = available_time.to.to_i % 1.day
      
      (start.._end - 1).each do |x|
        timetable[[x, date]] = true
      end
    end
    return timetable
  end
  
  private
  
  # validate that start time is before end time
  def start_time_not_after_end_time
    if from.present? and to.present? and from > to
      errors.add(:from, "is after end time")
    end
  end
  
  # validate 30-minute alignment for start and end times
  def start_and_end_time_aligned
    if from.present? and from.to_i % 30.minutes != 0
      errors.add(:from, "is not 30-minute aligned")
    end
    
    if to.present? and to.to_i % 30.minutes != 0
      errors.add(:to, "is not 30-minute aligned")
    end
  end
end
