class AddCreatorToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :created_by, :string
  end
end
