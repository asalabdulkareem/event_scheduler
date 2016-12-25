class Event < ActiveRecord::Base
  has_many :available_times
  validates_presence_of :event_type
  validates_presence_of :lecture_title
  validates_presence_of :description
  validates_presence_of :email
  validates_presence_of :num_times, if: "event_type == 'lecture'"
  validates_presence_of :duration
  after_initialize :generate_links
  
  private
  def generate_links
    self.link1 ||= SecureRandom.hex
    self.link2 ||= SecureRandom.hex
  end
end
