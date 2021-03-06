class Event < ActiveRecord::Base
  has_many :available_times
  has_many :students
  validates_presence_of :event_type
  validates_presence_of :lecture_title
  validates_presence_of :description
  validates_presence_of :email
  # only validate presense of number of times for lectures, not exams
  validates_presence_of :num_times, if: "event_type == 'lecture'"
  validates_presence_of :duration
  
  # generate links for every new event
  after_initialize :generate_links
  
  def url1
    return "https://#{Rails.configuration.x.host}/#{self.link1}"
  end
  
  def url2
    return "https://#{Rails.configuration.x.host}/#{self.link2}"
  end
  
  private
  def generate_links
    # generate random links (32 random hexadecimal characters)
    self.link1 ||= SecureRandom.hex
    self.link2 ||= SecureRandom.hex
  end
end
