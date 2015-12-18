require 'spec_helper'
require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  let(:visitor) { nil }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  permissions :index? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, user)
    end

    it "does not permit a user" do
      expect(subject).not_to permit(user, user)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, user)
    end
  end

  permissions :show? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, user)
    end

    it "permits a user" do
      expect(subject).to permit(user, user)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, user)
    end
  end

  permissions :destroy? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, user)
    end

    it "does not permit a user" do
      expect(subject).not_to permit(user, user)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, user)
    end
  end
end
