class AddAttachmentDocumentToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :word_document
      t.attachment :pdf_document
      t.attachment :plain_document
    end
  end

  def self.down
    remove_attachment :posts, :word_document
    remove_attachment :posts, :pdf_document
    remove_attachment :posts, :plain_document
  end
end
