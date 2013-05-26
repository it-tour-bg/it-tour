require 'spec_helper'

describe Event do
  it { belong_to :conference }
end
