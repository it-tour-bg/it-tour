require 'spec_helper'

describe Feedback do
  it { should belong_to :event }
  it { should validate_presence_of :event }
  it { should validate_presence_of :comment }
end
