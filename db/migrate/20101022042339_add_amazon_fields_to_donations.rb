class AddAmazonFieldsToDonations < ActiveRecord::Migration
  def self.up
    add_column :donations, :transaction_id, :string
    add_column :donations, :request_id,     :string
    add_column :donations, :status,         :string
  end

  def self.down
    remove_column :donations, :status
    remove_column :donations, :request_id
    remove_column :donations, :transaction_id
  end
end
