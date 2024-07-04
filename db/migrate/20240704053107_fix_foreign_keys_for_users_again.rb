class FixForeignKeysForUsersAgain < ActiveRecord::Migration[7.1]
  def change
    # Disable foreign keys temporarily
    execute "PRAGMA foreign_keys=off;"

    # Remove duplicate foreign keys
    remove_foreign_key :event_users, :users if foreign_key_exists?(:event_users, :users, column: :user_id)
    remove_foreign_key :comments, :users if foreign_key_exists?(:comments, :users, column: :user_id)
    remove_foreign_key :votes, :users if foreign_key_exists?(:votes, :users, column: :user_id)

    # Add foreign keys with cascade delete
    add_foreign_key :event_users, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :comments, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :votes, :users, column: :user_id, on_delete: :cascade

    # Re-enable foreign keys
    execute "PRAGMA foreign_keys=on;"
  end
end
