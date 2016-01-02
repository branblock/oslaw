class AddPostsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :post_id, :integer
    add_index :documents, :post_id
  end
end
