class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text    :content
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
