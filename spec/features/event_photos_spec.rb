require 'spec_helper_features'

feature "Event - Photos" do
  let!(:event) { create :event, {conference: create(:conference, domain: 'example.com')}.merge(event_attributes) }

  context "show photo gallery is off" do
    let(:event_attributes) { {show_photo_gallery: false} }

    it "doesn't display gallery" do
      visit root_path

      expect(page).not_to have_content 'Снимки'
    end
  end

  context "show photo gallery is on" do
    let(:event_attributes) { {show_photo_gallery: true} }

    it "displays gallery" do
      visit root_path

      expect(page).to have_content 'Снимки'
    end

    it "displays link to gallery when more the 9 photos" do
      10.times { create :photo, event: event }

      visit root_path
      click_on 'Виж всички снимки'

      expect(page).to have_content "Снимки от #{event.conference.name}"
    end
  end
end
