require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  it { should have_many(:posts) }
  it { should have_many(:comments) }

  describe "attributes" do
    it "should respond to first name" do
      expect(user).to respond_to(:first_name)
    end

    it "should respond to last name" do
      expect(user).to respond_to(:last_name)
    end

    it "should respond to username" do
      expect(user).to respond_to(:username)
    end

    it "should respond to email" do
      expect(user).to respond_to(:email)
    end

    it "should respond to role" do
      expect(user).to respond_to(:role)
    end

    it "should respond to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "should respond to member?" do
      expect(user).to respond_to(:standard?)
    end
  end
end
