class FixDuplicateForeignKeysInVotes < ActiveRecord::Migration[7.0]
  def change
    # Remove all foreign keys for user_id in votes
    if foreign_key_exists?(:votes, :users, column: :user_id)
      remove_foreign_key :votes, :users, column: :user_id
    end

    # Add the correct foreign key with ON DELETE CASCADE
    add_foreign_key :votes, :users, column: :user_id, on_delete: :cascade

    # Remove other duplicate foreign key if it exists
    if foreign_key_exists?(:votes, :users, column: :user_id, name: 'other_foreign_key_name')
      remove_foreign_key :votes, :users, column: :user_id, name: 'other_foreign_key_name'
    end
  end
end
