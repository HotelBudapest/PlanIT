class AddConfirmableToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :confirmation_token)
      add_column :users, :confirmation_token, :string
    end

    unless column_exists?(:users, :confirmed_at)
      add_column :users, :confirmed_at, :datetime
    end

    unless column_exists?(:users, :confirmation_sent_at)
      add_column :users, :confirmation_sent_at, :datetime
    end

    unless column_exists?(:users, :unconfirmed_email)
      add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
    end

    unless index_exists?(:users, :confirmation_token)
      add_index :users, :confirmation_token, unique: true
    end
  end
end
