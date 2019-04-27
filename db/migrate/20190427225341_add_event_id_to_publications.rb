class AddEventIdToPublications < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :event_id, :integer
  end

end
