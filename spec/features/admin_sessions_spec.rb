require 'spec_helper_features'

feature "Admin - Manage sessions" do
   sign_in

   let(:event) { create :event }

   scenario "creating session with minumum data" do
     visit admin_event_path(event)

     click_on '+ session'

     fill_in 'Title', with: 'Test session'
     fill_in 'Start at', with: '09:00'

     click_on 'Create'

     expect(page).to have_content 'Test session'
     expect(page).to have_content '09:00'

     session = event.sessions.first

     expect(session).to be_present
     expect(session.title).to eq 'Test session'
   end

   scenario "creating session with multiple speaker" do
     speaker1 = create :speaker, name: 'First speaker'
     speaker2 = create :speaker, name: 'Second speaker'
     speaker3 = create :speaker, name: 'Other speaker'

     visit admin_event_path(event)

     click_on '+ session'

     fill_in 'Title', with: 'Test session'
     fill_in 'Start at', with: '09:00'
     select speaker1.name, from: 'Speakers'
     select speaker2.name, from: 'Speakers'

     click_on 'Create'

     expect(page).to have_content speaker1.name
     expect(page).to have_content speaker2.name
     expect(page).not_to have_content speaker3.name

     session = event.sessions.first

     expect(session).to be_present
     expect(session.speakers).to eq [speaker1, speaker2]
   end

   scenario 'creating session on 2nd track' do
     visit admin_event_path(event)

     click_on '+ session'

     fill_in 'Title', with: 'Test session'
     fill_in 'Start at', with: '09:00'
     fill_in 'Track', with: '2'

     click_on 'Create'

     expect(page).to have_content 'Test session'
     expect(page).to have_content '09:00'
     expect(page).to have_content '2'

     session = event.sessions.first

     expect(session).to be_present
     expect(session.title).to eq 'Test session'
     expect(session.track).to eq 2
   end

   scenario "deleting session" do
     session = create :session, event: event

     visit admin_event_path(event)

     within 'table' do
       click_on 'Delete'
     end

     expect(page).not_to have_content session.title

     expect { session.reload }.to raise_error ActiveRecord::RecordNotFound
   end

   scenario "updating session" do
     session = create :session, event: event

     visit admin_event_path(event)

     within 'table' do
       click_on 'Edit'
     end

     fill_in 'Title', with: 'New title'

     click_on 'Update'

     expect(page).to have_content 'New title'

     expect { session.reload }.to change(session, :title).to 'New title'
   end
end
