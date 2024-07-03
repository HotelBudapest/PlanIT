class ClearEventsTableAndSetCreatorIdNotNull < ActiveRecord::Migration[6.1]
  def up
    Event.delete_all # This will delete all existing records in the events table
    change_column_null :events, :creator_id, false
  end

  def down
    change_column_null :events, :creator_id, true
  end
end
