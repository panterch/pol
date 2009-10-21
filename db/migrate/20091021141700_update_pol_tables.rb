class UpdatePolTables < ActiveRecord::Migration
  def self.up
    add_column :comps, :date_start, :date_time
    add_column :comps, :date_end, :date_time
    add_column :comps, :time_range, :string
  end

  def self.down
    remove_column :comps, :date_start
    remove_column :comps, :date_end
    remove_column :comps, :time_range
  end
end
