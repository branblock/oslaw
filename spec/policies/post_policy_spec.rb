require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { PostPolicy }

  let(:visitor) { nil }
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:post) { create(:post, user: user) }

  permissions :index?, :show?, :new?, :create?, :update?, :edit? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, post)
    end

    it "permits a user" do
      expect(subject).to permit(user, post)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, post)
    end
  end

  permissions :destroy? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, post)
    end

    it "does not permit a user" do
      expect(subject).not_to permit(user, post)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, post)
    end
  end
end
