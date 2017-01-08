class Student < ActiveRecord::Base
  has_many :selected_times
  belongs_to :event
  validates_presence_of :name
  validates_presence_of :event
end
