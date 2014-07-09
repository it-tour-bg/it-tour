# encode: utf-8
require 'spec_helper'

describe "Conference" do
  context "normal conference" do
    let(:conference) { create :conference, domain: 'example.com' }

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
  end
end
