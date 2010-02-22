class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string(:owner_type, :null => false)
      t.integer(:owner_id, :null => false)
      t.string(:name, :null => false, :length => 64)
      t.string(:value, :null => true, :length => 255)
      t.timestamps
    end
  end

  def self.down
    drop_table(:settings)
  end
end
