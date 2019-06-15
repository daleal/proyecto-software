class AddCreatorToPublications < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :created_by, :integer
  end
end
