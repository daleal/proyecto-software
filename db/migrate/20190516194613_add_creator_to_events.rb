class AddCreatorToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :created_by, :string
  end
end
