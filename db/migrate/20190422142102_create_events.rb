class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
