class CreatePolls < ActiveRecord::Migration[7.1]
  def change
    create_table :polls do |t|
      t.references :event, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
