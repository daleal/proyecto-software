class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :subject
      t.text :body
      t.boolean :read

      t.integer :conversation_id

      t.integer :user_id

      t.timestamps
    end
  end
end
