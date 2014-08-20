class FixTier < ActiveRecord::Migration
  def change
  	remove_column :comments, :tier, :string
  	add_column :comments, :tier, :int
  end
end
