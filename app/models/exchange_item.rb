# NOT IN USE, LIKELY SCRAPPED IN THE FUTURE

class ExchangeItem < ApplicationRecord
	validates :exchange_id, presence: true
	validates :item_id, presence: true

	belongs_to :exchange
	belongs_to :item
end
