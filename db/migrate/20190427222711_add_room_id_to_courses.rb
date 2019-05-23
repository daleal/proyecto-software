class AddRoomIdToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :room_id, :integer
  end

end
