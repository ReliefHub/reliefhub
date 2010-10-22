class ChangeProjectGoalToInteger < ActiveRecord::Migration
  def self.up
    change_column :projects, :goal, :integer, :default => 0, :null => false
  end

  def self.down
    change_column :projects, :goal, :decimal, :precision => 10, :scale => 2, :default => 0.0, :null => false
  end
end
