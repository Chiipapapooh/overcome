class CreateVisionApiTags < ActiveRecord::Migration[6.1]
  def change
    create_table :vision_api_tags do |t|
      t.string :name
      t.integer :post_id

      t.timestamps
    end
  end
end
