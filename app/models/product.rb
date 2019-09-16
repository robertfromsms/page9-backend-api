class Product < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :outside_ident, presence: true, uniqueness: true
	validates :img_path, presence: true, uniqueness: true

	has_many :items

	def sellers # currently not in use.
		items_being_sold_array = self.items.where(want_have_removed: "sell")
		seller_ids = items_being_sold_array.map { |item| item.user_id}
		sellers = User.where(id: [seller_ids])
		sellers
	end

	def buyers # currently not in use.
		items_being_bought_array = self.items.where(want_have_removed: "buy")
		buyer_ids = items_being_bought_array.map { |item| item.user_id}
		buyers = User.where(id: [buyer_ids])
		buyers
	end
end
