# relations will probably be different in the future

class Item < ApplicationRecord
	validates :product_id, presence: true
	validates :want_have_removed, presence: true
	validates :user_id, presence: true

	belongs_to :user
	belongs_to :product

	has_many :exchange_items
	has_many :exchanges, through: :exchange_items

	def product_name
  		self.product.name
  	end

  	def product_outside_ident
  		self.product.outside_ident
  	end

  	def product_image_path
  		self.product.img_path
  	end
end
