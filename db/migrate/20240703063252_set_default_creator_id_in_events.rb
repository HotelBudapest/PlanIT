class SetDefaultCreatorIdInEvents < ActiveRecord::Migration[6.1]
  def up
    default_user = User.first # Ensure there's at least one user in the database

    Event.where(creator_id: nil).update_all(creator_id: default_user.id)

    change_column_null :events, :creator_id, false
  end

  def down
    change_column_null :events, :creator_id, true
  end
end
