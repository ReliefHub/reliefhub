class AddTimestampsToProjects < ActiveRecord::Migration
  def self.up
    add_timestamps :projects
    add_column :projects, :status,           :string
    add_column :projects, :materials_needed, :string
    add_column :projects, :funding_needed,   :integer
    add_column :projects, :overview,         :text
  end

  def self.down
    remove_timestamps :projects
    remove_column :projects, :status
    remove_column :projects, :materials_needed
    remove_column :projects, :funding_needed
    remove_column :projects, :overview
  end
end
