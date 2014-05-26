require 'spec_helper'

describe EventDecorator do
  describe "#show_call_to_papers?" do
    def show_call_to_papers?(event)
      EventDecorator.new(event).show_call_to_papers?
    end

    it "returns false if call to papers is nil" do
      expect(show_call_to_papers?(Event.new(call_to_papers_url: nil))).to be_false
    end

    it "returns true if call to papers is set" do
      expect(show_call_to_papers?(Event.new(call_to_papers_url: 'http://example.org'))).to be_true
    end

    it "returns false if call to papers is set and sessions are announced" do
      expect(show_call_to_papers?(Event.new(call_to_papers_url: 'http://example.org', sessions_announced: true))).to be_false
    end
  end
end
