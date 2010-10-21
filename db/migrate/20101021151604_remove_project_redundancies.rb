class RemoveProjectRedundancies < ActiveRecord::Migration
  def self.up
    remove_column :projects, :funding_needed
    remove_column :projects, :photo_file_name
    remove_column :projects, :photo_content_type
    remove_column :projects, :photo_file_size
    remove_column :projects, :photo_updated_at
    remove_column :projects, :orphanage
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
