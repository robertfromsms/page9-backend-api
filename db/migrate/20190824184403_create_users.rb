class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :full_name, null: false
      t.string :address, null: false
      t.string :password_digest, null: false
      t.string :account_status
      t.string :email
      t.integer :seller_score
      t.integer :buyer_score

      t.timestamps
    end
  end
end
