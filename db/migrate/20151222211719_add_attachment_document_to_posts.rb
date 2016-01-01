class AddAttachmentDocumentToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :posts, :document
  end
end
