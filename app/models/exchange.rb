# NOT IN USE, KEPT FOR FUTURE DEVELOPMENT, the relations will probably be different
# an exchange will have wantlist item id, corresponding havelist item id, their users ids
# and a status, maybe initiater id?

class Exchange < ApplicationRecord
	validates :seller_ident, presence: true
	validates :buyer_ident, presence: true
	validates :exchange_status, presence: true

	has_many :exchange_items
	has_many :items, through: :exchange_items

	def seller
		User.find_by(id: self.seller_ident)
	end

	def buyer
		User.find_by(id: self.buyer_idents)
	end
end
