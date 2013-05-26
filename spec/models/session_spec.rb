require 'spec_helper'

describe Session do
  it { should belong_to :event }
  it { should belong_to :speaker }
  it { should validate_presence_of :event }
  it { should validate_presence_of :start_at }
end
