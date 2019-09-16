class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :outside_ident, null: false
      t.string :img_path, null: false

      t.timestamps
    end
  end
end
