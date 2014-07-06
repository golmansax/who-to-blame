class CreateWhoToBlameAuthors < ActiveRecord::Migration
  def change
    create_table :who_to_blame_authors do |t|
      t.string :full_name, null: false
      t.index :full_name, unique: true

      t.timestamps
    end
  end
end
