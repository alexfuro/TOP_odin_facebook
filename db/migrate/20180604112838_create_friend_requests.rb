class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.integer :requestor_id
      t.integer :requested_id
      t.boolean :accepted, default: nil

      t.timestamps
    end
    add_index :friend_requests, :requestor_id
    add_index :friend_requests, :requested_id
    add_index :friend_requests, [:requestor_id, :requested_id], unique: true
  end
end
