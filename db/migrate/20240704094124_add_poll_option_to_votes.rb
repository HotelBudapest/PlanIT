class AddPollOptionToVotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :votes, :poll_option, null: false, foreign_key: true
  end
end
