class UpdatePolTables < ActiveRecord::Migration
  def self.up
    add_column :comps, :date_start, :datetime
    add_column :comps, :date_end, :datetime
    add_column :comps, :time_range, :string
  end

  def self.down
    remove_column :comps, :date_start
    remove_column :comps, :date_end
    remove_column :comps, :time_range
  end
end
