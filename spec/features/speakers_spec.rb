require 'spec_helper_features'

feature "Speaker" do
  create_dummy_conference_event

  scenario "showing speaker page" do
    speaker = create :speaker

    visit speaker_path(speaker)

    expect(page).to have_content speaker.name
    expect(page).to have_content speaker.description
  end

  scenario "showing speaker sessions" do
    speaker = create :speaker

    session1 = create :session, speakers: [speaker]
    session2 = create :session, speakers: [speaker]

    visit speaker_path(speaker)

    expect(page).to have_content session1.title
    expect(page).to have_content session2.title
  end
end
