class AddCountryToOrganizations < ActiveRecord::Migration
  def self.up
    add_column :organizations, :country, :string
  end

  def self.down
    remove_column :organizations, :country 
  end
end
