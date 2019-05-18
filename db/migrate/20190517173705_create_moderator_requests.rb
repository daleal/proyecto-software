class CreateModeratorRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :moderator_requests do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
