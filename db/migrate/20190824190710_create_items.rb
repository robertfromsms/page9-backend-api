class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :product, foreign_key: true, null: false
      t.string :want_have_removed, null: false
      t.float :listing_price
      t.string :additional_info
      t.references :user, foreign_key: true, null: false


      t.timestamps
    end
  end
end
