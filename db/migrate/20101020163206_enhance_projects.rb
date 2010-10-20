class EnhanceProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :goal,   :decimal, :precision => 10, :scale => 2, :null => false, :default => 0
    add_column :projects, :raised, :decimal, :precision => 10, :scale => 2, :null => false, :default => 0
    add_column :projects, :photo_file_name,    :string
    add_column :projects, :photo_content_type, :string
    add_column :projects, :photo_file_size,    :integer
    add_column :projects, :photo_updated_at,   :datetime
    add_column :projects, :orphanage,   :string
    add_column :projects, :requestor,   :string
    add_column :projects, :description, :text
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
