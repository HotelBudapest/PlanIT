class AddCascadeDeleteToAssociations2 < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :events, :users, column: :creator_id
    add_foreign_key :events, :users, column: :creator_id, on_delete: :cascade

    remove_foreign_key :event_users, :users
    add_foreign_key :event_users, :users, on_delete: :cascade

    remove_foreign_key :comments, :users
    add_foreign_key :comments, :users, on_delete: :cascade

    remove_foreign_key :votes, :users
    add_foreign_key :votes, :users, on_delete: :cascade
  end
end
