class AddStatusToModeratorRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :moderator_requests, :status, :integer
  end
end
