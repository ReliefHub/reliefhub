class AddOrgIdIndexToProjects < ActiveRecord::Migration
  def self.up
    add_index :projects, :organization_id
  end

  def self.down
    remove_index :projects, :organization_id
  end
end
