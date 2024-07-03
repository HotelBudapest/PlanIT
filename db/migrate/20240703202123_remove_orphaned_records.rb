class RemoveOrphanedRecords < ActiveRecord::Migration[7.1]
  def up
    Event.where(creator_id: nil).delete_all
    EventUser.where(user_id: nil).delete_all
    Vote.where(user_id: nil).delete_all
    Comment.where(user_id: nil).delete_all
  end

  def down
  end
end
