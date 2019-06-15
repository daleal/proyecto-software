class AddCourseIdToPublications < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :course_id, :integer
  end

end
