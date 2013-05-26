require 'spec_helper'

describe Speaker do
  it { should have_many :sessions }
  it { should validate_presence_of :name }
end
