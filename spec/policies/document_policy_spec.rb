require 'rails_helper'

RSpec.describe DocumentPolicy do
  subject { described_class }

  let(:visitor) { nil }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:post) { FactoryGirl.create(:post, user: user) }
  let(:document) { FactoryGirl.create(:document, post: post) }

  permissions :new?, :create? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, document)
    end

    it "permits a user" do
      expect(subject).to permit(user, document)
    end
  end

  permissions :destroy? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, document)
    end

    it "permits a user" do
      expect(subject).to permit(user, document)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, document)
    end
  end
end
