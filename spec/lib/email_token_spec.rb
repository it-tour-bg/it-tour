require 'spec_helper'

describe EmailToken do
  it "can reversed to user id" do
    user = create :subscriber
    expect(EmailToken.for(user).user_id).to eq user.id
    expect(EmailToken.user_id(EmailToken.for(user))).to eq user.id
  end

  it "can handle invalid token inputs" do
    expect(EmailToken.user_id(0)).to eq 0
    expect(EmailToken.user_id('0')).to eq 0
    expect(EmailToken.user_id('invalid')).to eq 0
  end

  it "is different for different users" do
    user  = create :subscriber
    other = create :subscriber

    expect(EmailToken.for(user)).not_to eq EmailToken.for(other)
  end

  it "can be compared" do
    expect(EmailToken.new('token')).to eq EmailToken.new('token')
    expect(EmailToken.new('token')).not_to eq EmailToken.new('other token')
  end

  it "can be compared to strings" do
    expect(EmailToken.new('token')).to eq 'token'
    expect(EmailToken.new('token')).not_to eq 'other token'
  end
end

