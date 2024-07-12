class AddDefaultToPinnedInComments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :comments, :pinned, from: nil, to: false
    Comment.where(pinned: nil).update_all(pinned: false)
  end
end
