class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :initials
      t.string :name
      t.string :teacher_name
      t.timestamps
    end
  end
end
