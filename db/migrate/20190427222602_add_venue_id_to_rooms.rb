class AddVenueIdToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :venue_id, :integer
  end

end
