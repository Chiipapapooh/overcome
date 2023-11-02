class CreateNewsLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :news_letters do |t|
      t.integer :genre_id, null: false
      t.string :news_title, null: false
      t.string :news_text, null: false
      t.integer :sharing_status, null: false, default: 0

      t.timestamps
    end
  end
end
