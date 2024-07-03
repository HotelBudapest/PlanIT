class RemoveDuplicateForeignKeysFromVotes < ActiveRecord::Migration[7.0]
  def change
    # Remove duplicate foreign key for user_id in votes
    if foreign_key_exists?(:votes, :users, column: :user_id)
      remove_foreign_key :votes, :users, column: :user_id
    end

    # Add the foreign key with ON DELETE CASCADE if it's not already there
    unless foreign_key_exists?(:votes, :users, column: :user_id, on_delete: :cascade)
      add_foreign_key :votes, :users, column: :user_id, on_delete: :cascade
    end
  end
end
