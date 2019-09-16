class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.integer :seller_ident, null: false
      t.integer :buyer_ident, null: false
      t.string :exchange_status, null: false

      t.timestamps
    end
  end
end
