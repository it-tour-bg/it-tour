require 'spec_helper'

describe Conference do
  it { should validate_presence_of :name }
  it { should validate_presence_of :contact_name }
  it { should validate_presence_of :contact_email }
  it { should have_many :events }
end
