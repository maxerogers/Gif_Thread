class Comments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.string :username
  		t.string :gif_url
  		t.string :data
  		t.belongs_to :parent
  		t.timestamps
  	end
  end
end
