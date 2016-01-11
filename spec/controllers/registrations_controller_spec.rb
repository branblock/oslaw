require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:user) { create(:user, email: 'old@example.com') }

  describe "successfully updates a user" do
    login_user
    it "changes the user's attributes" do
      put :update, user: { email: 'new@example.com', current_password: 'password' }
      subject.current_user.reload
      expect(subject.current_user.email).to eq 'new@example.com'
    end
  end
end
