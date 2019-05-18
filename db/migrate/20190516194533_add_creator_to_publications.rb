class AddCreatorToPublications < ActiveRecord::Migration[5.1]
  def change
    add_column :publications, :created_by, :string
  end
end
