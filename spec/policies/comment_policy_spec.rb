require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { CommentPolicy }

  let(:visitor) { nil }
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:comment) { create(:comment, user: user) }

  permissions :new?, :create? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, comment)
    end

    it "permits a user" do
      expect(subject).to permit(user, comment)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, comment)
    end
  end

  permissions :destroy? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, comment)
    end

    it "does not permit a user" do
      expect(subject).not_to permit(user, comment)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, comment)
    end
  end
end
