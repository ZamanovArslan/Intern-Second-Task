require "rails_helper"

describe "Event" do
  include_context "when user signed in"
  let!(:event) { create(:event, user: user, date_event: Date.today) }
  let(:new_event) { build(:event) }

  context "with valid credentials" do
    it "can be updated" do
      visit "/"

      find("a[href='#{edit_event_path(event)}']").click
      fill_in :event_name_of_event, with: new_event.name_of_event
      click_button "Update Event"

      expect(page).to have_content(new_event.name_of_event)
    end
  end
end