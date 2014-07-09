require 'spec_helper_features'

feature "Subscribers" do
  create_dummy_conference_event

  scenario "unsubscribe" do
    subscriber = create :subscriber

    visit unsubscribe_path(subscriber.token)

    expect(page).to have_text 'отписан успешно'

    expect { subscriber.reload }.to change(subscriber, :active?).to false
  end
end
