class AddRoomIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :room_id, :integer
  end

end
