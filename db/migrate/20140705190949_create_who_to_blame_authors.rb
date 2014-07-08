class CreateWhoToBlameAuthors < ActiveRecord::Migration
  def change
    create_table :who_to_blame_authors do |t|
      t.string :full_name, null: false

      t.timestamps
    end
    add_index :who_to_blame_authors, :full_name, unique: true
  end
end
