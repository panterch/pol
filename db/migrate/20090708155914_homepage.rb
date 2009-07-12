class Homepage < ActiveRecord::Migration
  def self.up
    unless Page.root
      Page.create!(:title => 'Home', :permalink => 'index')
    end
  end

  def self.down
  end
end
