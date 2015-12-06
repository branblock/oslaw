describe CommentPolicy do
  subject { CommentPolicy }

  let(:user) { create(:user) }
  let(:admin_user) { create(:user, role: :admin) }

  permissions :destroy? do
    it "does not allow a standard user to delete a comment" do
      expect(subject).not_to permit(user)
    end
    it "allows an admin to delete the comment" do
      expect(subject).to permit(admin)
    end
  end
end
