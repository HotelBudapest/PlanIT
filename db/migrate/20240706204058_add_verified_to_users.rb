class AddVerifiedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :verified, :boolean
  end
end
