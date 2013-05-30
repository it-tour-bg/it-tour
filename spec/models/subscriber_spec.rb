require 'spec_helper'

describe Subscriber do
  it { should belong_to :conference }
  it { should validate_presence_of :email }
end
