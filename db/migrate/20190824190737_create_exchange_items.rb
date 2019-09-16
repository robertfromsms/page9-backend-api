class CreateExchangeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :exchange_items do |t|
      t.references :exchange, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false


      t.timestamps
    end
  end
end
