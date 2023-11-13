class CreateNewsLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :news_letters do |t|
      t.integer :genre_id, null: false
      t.string :news_title, null: false
      t.string :news_text, null: false
      t.boolean :is_draft, null: false, default: true

      t.timestamps
    end
  end
end
