class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :post_name
      t.string :post_title
      t.text :post_content
      t.string :post_time
      t.string :post_password
      t.string :post_password2
      t.timestamps null: false
    end
  end
end
