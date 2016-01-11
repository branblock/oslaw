require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.build_stubbed(:admin) }

  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many(:bookmarks) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }

  it { should have_attached_file(:avatar) }
  it { should validate_attachment_content_type(:avatar).
                  allowing('image/png', 'image/gif').
                  rejecting('text/plain', 'text/xml') }

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

    it "should respond to standard?" do
      expect(user).to respond_to(:standard?)
    end

    it "should set the role of 'standard'" do
      expect(user.role).to eq('standard')
    end

    it "should set the role of 'admin'" do
      expect(admin.role).to eq('admin')
    end

    it "should set the role of 'standard' by default" do
      expect(user.role).to eq('standard')
    end

    describe "attributes" do
      it "should respond to avatar" do
        expect(user).to respond_to(:avatar)
      end
    end
  end

  describe "favorite(post)" do
    it "returns `nil` if the user has not favorited the post" do
      post = FactoryGirl.create(:post)
      expect(user.favorite(post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      post = FactoryGirl.create(:post)
      favorite = user.favorites.where(post: post).create
      expect(user.favorite(post)).to eq(favorite)
    end
  end
end
