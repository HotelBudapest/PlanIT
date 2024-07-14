class FixForeignKeysForUsersAgain2 < ActiveRecord::Migration[7.1]
  def change
    # Remove existing foreign keys
    remove_foreign_key :event_users, :users if foreign_key_exists?(:event_users, :users, column: :user_id)
    remove_foreign_key :event_users, :users, name: "event_users_user_id_foreign_key" if foreign_key_exists?(:event_users, :users, name: "event_users_user_id_foreign_key")
    remove_foreign_key :comments, :users if foreign_key_exists?(:comments, :users, column: :user_id)
    remove_foreign_key :votes, :users if foreign_key_exists?(:votes, :users, column: :user_id)
  end
end
