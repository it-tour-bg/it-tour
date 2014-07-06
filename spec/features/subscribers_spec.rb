require 'spec_helper'

feature "Subscribers" do
  before do
    create :event, conference: create(:conference, domain: 'example.com')
  end

  scenario "unsubscribe" do
    subscriber = create :subscriber

    visit unsubscribe_path(subscriber.token)

    expect(page).to have_text 'отписан успешно'

    expect { subscriber.reload }.to change(subscriber, :active?).to false
  end
end
