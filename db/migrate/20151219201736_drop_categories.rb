class DropCategories < ActiveRecord::Migration
  def change
    drop_table :categories do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

    remove_column :posts, :category_id, :integer
  end
end
