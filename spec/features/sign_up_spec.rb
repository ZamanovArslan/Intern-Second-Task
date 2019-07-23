require "rails_helper"

describe "Visitor" do
  let(:user) { build :user }

  def sign_up(email, password, surname)
    visit new_user_registration_path

    fill_in :user_surname, with: surname
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_button "Sign up"
  end

  context "with valid credentials" do
    it "can signs up" do
      sign_up(user.email, user.password, user.surname)

      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end
end
