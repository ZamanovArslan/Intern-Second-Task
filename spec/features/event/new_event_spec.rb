require "rails_helper"

describe "Event" do
  include_context "when user signed in"
  let(:event) { build(:event, user: user, date_event: Date.today) }

  context "with form on homepage" do
    it "can be added" do
      visit "/"

      fill_in :event_name_of_event, with: event.name_of_event
      find("option[value='" + event.regularity + "']").click
      fill_in :event_date_event, with: event.date_event

      click_button "Create Event"

      expect(page).to have_content(event.name_of_event)
      expect(page).to have_content("Event added successfully")
    end
  end
end
