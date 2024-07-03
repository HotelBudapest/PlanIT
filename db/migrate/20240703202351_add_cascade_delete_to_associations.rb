class AddCascadeDeleteToAssociations < ActiveRecord::Migration[7.1]
  def change
    # Remove existing foreign keys if any to avoid conflicts
    remove_foreign_key :events, :users, column: :creator_id if foreign_key_exists?(:events, :users, column: :creator_id)
    remove_foreign_key :event_users, :events if foreign_key_exists?(:event_users, :events)
    remove_foreign_key :event_users, :users if foreign_key_exists?(:event_users, :users)
    remove_foreign_key :votes, :polls if foreign_key_exists?(:votes, :polls)
    remove_foreign_key :votes, :users if foreign_key_exists?(:votes, :users)
    remove_foreign_key :comments, :events if foreign_key_exists?(:comments, :events)
    remove_foreign_key :comments, :users if foreign_key_exists?(:comments, :users)

    # Add foreign keys with cascade delete
    add_foreign_key :events, :users, column: :creator_id, on_delete: :cascade
    add_foreign_key :event_users, :events, on_delete: :cascade
    add_foreign_key :event_users, :users, on_delete: :cascade
    add_foreign_key :votes, :polls, on_delete: :cascade
    add_foreign_key :votes, :users, on_delete: :cascade
    add_foreign_key :comments, :events, on_delete: :cascade
    add_foreign_key :comments, :users, on_delete: :cascade
  end
end
