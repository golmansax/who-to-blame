class CreateWhoToBlameFileTypes < ActiveRecord::Migration
  def change
    create_table :who_to_blame_file_types do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :who_to_blame_file_types, :name, unique: true
  end
end
