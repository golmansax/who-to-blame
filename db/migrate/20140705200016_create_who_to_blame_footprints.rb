class CreateWhoToBlameFootprints < ActiveRecord::Migration
  def change
    create_table :who_to_blame_footprints do |t|
      t.date :date, null: false
      t.integer :num_lines, null: false
      t.belongs_to :author, null: false
      t.belongs_to :file_type, null: false

      t.timestamps
    end
  end
end
