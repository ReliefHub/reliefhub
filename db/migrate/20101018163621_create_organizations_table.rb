class CreateOrganizationsTable < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string   :name
      t.string   :street1
      t.string   :street2
      t.string   :city
      t.string   :state
      t.string   :zip
      t.string   :contact_person
      t.string   :phone_number
      t.text     :overview
      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
