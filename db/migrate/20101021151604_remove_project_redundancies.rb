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
    add_column :projects, :funding_needed,   :integer
    add_column :projects, :photo_file_name,    :string
    add_column :projects, :photo_content_type, :string
    add_column :projects, :photo_file_size,    :integer
    add_column :projects, :photo_updated_at,   :datetime
    add_column :projects, :orphanage,   :string
  end
end
