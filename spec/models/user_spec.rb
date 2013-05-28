require 'spec_helper'

describe User do
  it { create(:user).should validate_uniqueness_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end
