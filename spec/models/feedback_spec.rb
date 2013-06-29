require 'spec_helper'

describe Feedback do
  it { should belong_to :event }
  it { should validate_presence_of :event }
  it { should validate_presence_of :comment }

  describe ".for_event" do
    it "can select only feedbacks from certain event" do
      feedback = create :feedback
      other    = create :feedback

      expect(Feedback.for_event(feedback.event_id)).to eq [feedback]
    end

    it "return all feedbacks if no event id is given" do
      feedback_1 = create :feedback
      feedback_2 = create :feedback

      expect(Feedback.for_event(nil)).to eq [feedback_2, feedback_1]
    end
  end
end
