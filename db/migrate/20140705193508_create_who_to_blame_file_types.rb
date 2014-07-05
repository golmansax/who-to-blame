class CreateWhoToBlameFileTypes < ActiveRecord::Migration
  def change
    create_table :who_to_blame_file_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
