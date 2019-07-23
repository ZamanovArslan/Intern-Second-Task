require "rails_helper"

describe "User" do
  let(:user) { create :user }

  def sign_in(email, password)
    visit new_user_session_path

    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_button "Log in"
  end

  context "with valid credentials" do

    it "can sign in" do
      sign_in(user.email, user.password)

      expect(page).to have_content("Signed in successfully")
    end
  end
end
