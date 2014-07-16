require 'spec_helper_features'

feature "Event - session and speakers" do
  let(:event) { create :event, {conference: create(:conference, domain: 'example.com')}.merge(event_attributes) }

  let!(:session) { create :session, event: event }

  context "sessions not announced" do
    let(:event_attributes) { {sessions_announced: false} }

    it "doesn't display sessions" do
      visit root_path

      expect(page).not_to have_content 'Програма'
      expect(page).not_to have_content session.title
    end
  end

  context "sessions announced" do
    let(:event_attributes) { {sessions_announced: true} }

    it "displays sessions" do
      visit root_path

      expect(page).to have_content 'Програма'
      expect(page).to have_content session.title
    end

    it "displays sessions with two speakers" do
      speaker1 = create(:session_speaker, session: session).speaker
      speaker2 = create(:session_speaker, session: session).speaker

      visit root_path

      within '#schedule' do
        expect(page).to have_content "#{speaker1.name}, #{speaker2.name}"
      end
    end

  end

  context "speaker not announced" do
    let(:event_attributes) { {speakers_announced: false} }

    it "doesn't display speakers" do
      speaker = create(:session_speaker, session: session).speaker

      visit root_path

      expect(page).not_to have_content 'Лектори'
      expect(page).not_to have_content speaker.name
    end
  end

  context "speaker announced" do
    let(:event_attributes) { {speakers_announced: true} }

    it "displays session speaker" do
      speaker = create(:session_speaker, session: session).speaker

      visit root_path

      expect(page).to have_content 'Лектори'
      expect(page).to have_content speaker.name
      expect(page).to have_content speaker.description
    end

    it "displays sessions speakers event if there is more than one speaker" do
      speaker1 = create(:session_speaker, session: session).speaker
      speaker2 = create(:session_speaker, session: session).speaker

      visit root_path

      expect(page).to have_content "#{speaker1.name}#{speaker2.name}"
      expect(page).to have_content speaker1.name
      expect(page).to have_content speaker1.description
      expect(page).to have_content speaker2.name
      expect(page).to have_content speaker2.description
    end
  end
end
