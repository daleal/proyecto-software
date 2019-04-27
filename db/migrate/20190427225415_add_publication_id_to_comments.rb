class AddPublicationIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :publication_id, :integer
  end

end
