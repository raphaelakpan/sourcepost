require "rails_helper"

describe "User Signup", type: :feature do
  let(:user) { build(:user) }

  before(:each) do
    visit signup_path
  end

  context "When user visits Signup Page" do
    scenario "user see Signup Message" do
      expect(page.has_text? "Sign Up").to be true
    end
  end

  context "With invalid user details" do
    scenario "user is not created" do
      expect(User.all.size).to be 0

      click_button "Create my Account"

      expect(User.all.size).to be 0
    end

    scenario "Email is Validated" do
      click_button "Create my Account"

      expect(page.has_content? "Email is invalid").to be true
      expect(page.has_content? "Email can't be blank").to be true
    end

    scenario "Name is Validated" do
      click_button "Create my Account"

      expect(page.has_content? "Name can't be blank").to be true
      expect(page.has_content? "Name is too short (minimum is 5 characters)").to be true
    end

    scenario "Password is Validated" do
      click_button "Create my Account"

      expect(page.has_content? "Password can't be blank").to be true
      expect(page.has_content? "Password is too short (minimum is 6 characters)").to be true
    end

    scenario "Password Confirmation is Validated" do
      click_button "Create my Account"

      expect(page.has_content? "Password Confirmation can't be blank").to be true
    end
  end

  context "With valid user details" do
    scenario "user is created" do
      expect(User.all.size).to be 0

      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation

      click_button "Create my Account"

      saved_user = User.find_by(email: user.email)

      expect(User.all.size).to be 1
      expect(saved_user.name).to eq user.name
    end
  end
end


