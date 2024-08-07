class CreatePollOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :poll_options do |t|
      t.string :title, null: false
      t.references :poll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
