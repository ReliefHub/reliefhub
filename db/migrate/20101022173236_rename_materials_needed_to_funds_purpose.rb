class RenameMaterialsNeededToFundsPurpose < ActiveRecord::Migration
  def self.up
    rename_column :projects, :materials_needed, :funds_purpose
  end

  def self.down
    rename_column :projects, :funds_purpose, :materials_needed
  end
end
