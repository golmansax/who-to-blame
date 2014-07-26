class AddIndexOnDateToFootprints < ActiveRecord::Migration
  def change
    add_index :who_to_blame_footprints, :date
  end
end
