class AvailableTime < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event
  validates_presence_of :from
  validates_presence_of :to
  validate :start_time_not_after_end_time
  validate :start_and_end_time_aligned
  
  private
  def start_time_not_after_end_time
    if from.present? and to.present? and from > to
      errors.add(:from, "is after end time")
    end
  end
  
  def start_and_end_time_aligned
    if from.present? and from.to_i % 30.minutes != 0
      errors.add(:from, "is not 30-minute aligned")
    end
    
    if to.present? and to.to_i % 30.minutes != 0
      errors.add(:to, "is not 30-minute aligned")
    end
  end
end
