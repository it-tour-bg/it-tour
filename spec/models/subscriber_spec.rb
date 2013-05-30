require 'spec_helper'

describe Subscriber do
  it { should belong_to :conference }
  it { should validate_presence_of :email }

  it "can returns its first error message" do
    subscriber = Subscriber.new
    subscriber.valid?
    expect(subscriber.error_message).to eq "Email can't be blank"
  end
end
