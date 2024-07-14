class FixForeignKeysInVotes < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      -- Drop existing foreign key constraints
      ALTER TABLE votes DROP CONSTRAINT IF EXISTS votes_poll_id_fkey;
      ALTER TABLE votes DROP CONSTRAINT IF EXISTS votes_user_id_fkey;

      -- Add new foreign key constraints
      ALTER TABLE votes ADD CONSTRAINT votes_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES polls(id);
      ALTER TABLE votes ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
    SQL
  end
end
