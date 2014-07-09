# encode: utf-8
require 'spec_helper'

describe "Conference" do
  context "normal conference" do
    let(:conference) { create :conference, domain: 'example.com' }

    describe "Sessions & Speakers" do
      let!(:session) { create :session, event: event }

      context "sessions not announced" do
        let!(:event) { create :event, conference: conference, sessions_announced: false }

        it "doesn't display sessions" do
          visit root_path

          expect(page).not_to have_content 'Програма'
          expect(page).not_to have_content session.title
        end
      end

      context "sessions announced" do
        let!(:event) { create :event, conference: conference, sessions_announced: true }

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
            expect(page).to have_content "#{speaker1.name}#{speaker2.name}"
          end
        end

      end

      context "speaker not announced" do
        let!(:event) { create :event, conference: conference, speakers_announced: false }

        it "doesn't display speakers" do
          speaker = create(:session_speaker, session: session).speaker

          visit root_path

          expect(page).not_to have_content 'Лектори'
          expect(page).not_to have_content speaker.name
        end
      end

      context "speaker announced" do
        let!(:event) { create :event, conference: conference, speakers_announced: true }

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

    describe "Subscribe" do
      it "is always displayed" do
        create :event, conference: conference

        visit root_path

        expect(page).to have_content 'Записвания'
      end
    end

    describe "Archive" do
      it "isn't displayed when they aren't other event of current conference" do
        create :event, conference: conference

        visit root_path

        expect(page).not_to have_content 'Архив'
      end

      it "is displayed when they aren't at least two events current conference" do
        2.times { create :event, conference: conference }

        visit root_path

        expect(page).to have_content 'Архив'
      end
    end

    describe "Photos" do
      it "isn't displayed when they aren't other event of current conference" do
        create :event, conference: conference, show_photo_gallery: false

        visit root_path

        expect(page).not_to have_content 'Снимки'
      end

      it "is displayed when they aren't at least two events current conference" do
        create :event, conference: conference, show_photo_gallery: true

        visit root_path

        expect(page).to have_content 'Снимки'
      end

      specify "more the 9 photos" do
        event = create :event, conference: conference, show_photo_gallery: true

        10.times { create :photo, event: event }

        visit root_path
        click_on 'Виж всички снимки'

        expect(page).to have_content "Снимки от #{conference.name}"
      end
    end
  end
end
