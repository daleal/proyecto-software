class AddContentToModeratorRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :moderator_requests, :content, :text
  end
end
