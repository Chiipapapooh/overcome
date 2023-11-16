class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :post_id, null: false
      t.integer :customer_id, null: false
      t.string :report

      t.timestamps
    end
  end
end
