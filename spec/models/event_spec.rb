require 'spec_helper'

describe Event do
  it { belong_to :conference }
  it { validate_presence_of :name }
  it { validate_presence_of :conference }
  it { validate_presence_of :date }

  it "has full name" do
    event = Event.new name: '2013', conference: Conference.new(name: 'VarnaConf')
    expect(event.full_name).to eq 'VarnaConf 2013'
  end
end
