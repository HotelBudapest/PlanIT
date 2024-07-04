class OnceAgain < ActiveRecord::Migration[7.1]
  def change

    # Add foreign keys with cascade delete
    add_foreign_key :event_users, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :comments, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :votes, :users, column: :user_id, on_delete: :cascade

    # Re-enable foreign keys
    execute "PRAGMA foreign_keys=on;"
  end
end
