require 'spec_helper'

describe Event do
  it { should belong_to :conference }
  it { should have_many :sessions }

  it { should validate_presence_of :name }
  it { should validate_presence_of :conference }
  it { should validate_presence_of :date }
  it { should validate_presence_of :state }

  it "has full name" do
    event = Event.new name: '2013', conference: Conference.new(name: 'VarnaConf')
    expect(event.full_name).to eq 'VarnaConf 2013'
  end
end
