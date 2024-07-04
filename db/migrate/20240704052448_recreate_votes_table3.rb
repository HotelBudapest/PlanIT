class RecreateVotesTable3 < ActiveRecord::Migration[7.1]
  def change
    # Disable foreign keys temporarily
    execute "PRAGMA foreign_keys=off;"

    # Create a new votes table with the correct foreign key constraints
    create_table :votes_new do |t|
      t.references :poll, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :status
      t.timestamps
    end

    # Copy data from the old votes table to the new one
    execute <<-SQL
      INSERT INTO votes_new (id, poll_id, user_id, status, created_at, updated_at)
      SELECT id, poll_id, user_id, status, created_at, updated_at FROM votes;
    SQL

    # Drop the old votes table
    drop_table :votes

    # Rename the new votes table to votes
    rename_table :votes_new, :votes

    # Re-enable foreign keys
    execute "PRAGMA foreign_keys=on;"
  end
end
