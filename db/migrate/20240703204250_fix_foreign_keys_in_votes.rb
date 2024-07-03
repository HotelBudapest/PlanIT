class FixForeignKeysInVotes < ActiveRecord::Migration[7.0]
  def change
    # Remove all foreign keys for user_id in votes
    execute <<-SQL
      PRAGMA foreign_keys=off;
      CREATE TABLE votes_new (
        id INTEGER PRIMARY KEY,
        poll_id INTEGER,
        user_id INTEGER,
        status STRING,
        created_at DATETIME,
        updated_at DATETIME,
        FOREIGN KEY (poll_id) REFERENCES polls(id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      );
      INSERT INTO votes_new (id, poll_id, user_id, status, created_at, updated_at)
      SELECT id, poll_id, user_id, status, created_at, updated_at FROM votes;
      DROP TABLE votes;
      ALTER TABLE votes_new RENAME TO votes;
      PRAGMA foreign_keys=on;
    SQL
  end
end
