class CreateWhoToBlameFootprints < ActiveRecord::Migration
  def change
    create_table :who_to_blame_footprints do |t|
      t.date :date
      t.integer :num_lines
      t.belongs_to :author
      t.belongs_to :file_type

      t.timestamps
    end
  end
end
