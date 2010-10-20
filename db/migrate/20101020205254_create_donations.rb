class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :amount
      
      t.timestamps
    end
    
    remove_column :projects, :raised
  end

  def self.down
    drop_table :donations
    add_column :projects, :raised, :integer
  end
end
