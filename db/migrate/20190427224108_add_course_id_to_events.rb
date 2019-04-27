class AddCourseIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :course_id, :integer
  end

end
