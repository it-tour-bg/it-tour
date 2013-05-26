require 'spec_helper'

describe Speaker do
  it { should validate_presence_of :name }
end
