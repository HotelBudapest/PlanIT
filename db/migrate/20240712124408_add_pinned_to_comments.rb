class AddPinnedToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :pinned, :boolean
  end
end
