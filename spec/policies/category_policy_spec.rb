require 'spec_helper'
require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class }

  let(:visitor) { nil }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:category) { FactoryGirl.create(:category, user: user) }

  permissions :index?, :show? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, category)
    end

    it "permits a user" do
      expect(subject).to permit(user, category)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, category)
    end
  end

  permissions :new?, :create?, :update?, :edit?, :destroy? do
    it "does not permit a visitor" do
      expect(subject).not_to permit(visitor, category)
    end

    it "does not permit a user" do
      expect(subject).not_to permit(user, category)
    end

    it "permits an admin user" do
      expect(subject).to permit(admin, category)
    end
  end
end
