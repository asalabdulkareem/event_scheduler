require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:event) { build :event }
  subject { described_class.new name: "Ahmad", event: event }
  
  # should be valid by default
  it "should be valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  # should not be valid if name missing
  it "should not be valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  
  # should not be valid if event missing
  it "should not be valid without event" do
    subject.event = nil
    expect(subject).to_not be_valid
  end
  
end
