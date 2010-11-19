class AddEmailAndUrlToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :email_address, :string
    add_column :organizations, :website, :string
  end

  def self.down
    remove_column :organizations, :website
    remove_column :organizations, :email_address
  end
end
