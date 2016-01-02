class AddAttachmentUploadToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :documents, :upload
  end
end
