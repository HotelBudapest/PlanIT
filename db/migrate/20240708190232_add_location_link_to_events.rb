class AddLocationLinkToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :location_link, :string
  end
end
