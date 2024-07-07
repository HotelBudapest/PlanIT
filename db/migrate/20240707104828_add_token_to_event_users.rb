class AddTokenToEventUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :event_users, :token, :string
  end
end
