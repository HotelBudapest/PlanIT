class AddCascadeDeleteToAssociationsAgain < ActiveRecord::Migration[7.0]
  def change
    # Ensure to drop the foreign keys if they exist
    remove_foreign_key :events, :users, column: :creator_id, if_exists: true
    add_foreign_key :events, :users, column: :creator_id, on_delete: :cascade

    remove_foreign_key :event_users, :users, if_exists: true
    add_foreign_key :event_users, :users, on_delete: :cascade

    remove_foreign_key :comments, :users, if_exists: true
    add_foreign_key :comments, :users, on_delete: :cascade

    remove_foreign_key :votes, :users, if_exists: true
    add_foreign_key :votes, :users, on_delete: :cascade
  end
end
