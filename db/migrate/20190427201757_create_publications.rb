class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :title
      t.text :description
      t.datetime :publication_date

      t.timestamps
    end
  end
end
