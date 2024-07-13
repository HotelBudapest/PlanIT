class AddFirstNameLastNameAndPhoneNumberToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :first_name)
      add_column :users, :first_name, :string
    end

    unless column_exists?(:users, :last_name)
      add_column :users, :last_name, :string
    end

    unless column_exists?(:users, :phone_number)
      add_column :users, :phone_number, :string, limit: 20
    end
  end
end
