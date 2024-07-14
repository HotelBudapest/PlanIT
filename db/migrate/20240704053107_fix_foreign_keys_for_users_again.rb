class FixForeignKeysForUsersAgain < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      -- Drop existing foreign key constraints
      ALTER TABLE votes DROP CONSTRAINT IF EXISTS votes_poll_id_fkey;
      ALTER TABLE votes DROP CONSTRAINT IF EXISTS votes_user_id_fkey;

      -- Recreate the votes table with the correct foreign keys
      CREATE TABLE votes_new (
        id SERIAL PRIMARY KEY,
        poll_id INTEGER,
        user_id INTEGER,
        status VARCHAR,
        created_at TIMESTAMP,
        updated_at TIMESTAMP,
        FOREIGN KEY (poll_id) REFERENCES polls(id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      );

      -- Copy the data from the old votes table to the new votes table
      INSERT INTO votes_new (id, poll_id, user_id, status, created_at, updated_at)
      SELECT id, poll_id, user_id, status, created_at, updated_at FROM votes;

      -- Drop the old votes table
      DROP TABLE votes;

      -- Rename the new votes table to votes
      ALTER TABLE votes_new RENAME TO votes;
    SQL
  end
end
