class SelectedTime < ActiveRecord::Base
  belongs_to :student
  validates_presence_of :student
  validates_presence_of :from
  validate :start_time_aligned
  
  def start_time_aligned
    if from.present? and from.to_i % 30.minutes != 0
      errors.add(:from, "is not 30-minute aligned")
    end
  end
end
