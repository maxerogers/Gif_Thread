class AddTier < ActiveRecord::Migration
  def change
  	add_column :comments, :tier, :string
  end
end
