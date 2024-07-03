class ChangeCreatorIdInEventsToNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :events, :creator_id, false
  end
end
