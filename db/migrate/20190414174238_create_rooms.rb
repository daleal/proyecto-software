class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :letter
      t.integer :number

      t.timestamps
    end
  end
end
