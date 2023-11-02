class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :genre_id, null: false
      t.string :title, null: false
      t.string :text, null: false
      t.integer :sharing_status, null: false, default: 0

      t.timestamps
    end
  end
end
