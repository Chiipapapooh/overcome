class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :text, null: false
      t.boolean :is_draft, null: false, default: true
      t.integer :customer_id, null: false
      t.string :nickname, null: false

      t.timestamps
    end
  end
end
