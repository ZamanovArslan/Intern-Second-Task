require "rails_helper"

describe "User" do
  include_context "when user signed in"
  let(:new_data) { build(:user, password: "1234567") }

  context "with valid credentials" do
    it "can modify self data" do
      visit edit_user_registration_path

      fill_form(:user, :edit, email: new_data.email, password: new_data.password,
                              password_confirmation: new_data.password, current_password: user.password)
      click_button "Update"

      expect(page).to have_content("Your account has been updated successfully.")

      expect(page).to have_content(new_data.email.upcase)
    end
  end
end
