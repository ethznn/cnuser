class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
        
        t.text :content
        t.text :name
        t.integer :post_id
        
      t.timestamps null: false
    end
  end
end
