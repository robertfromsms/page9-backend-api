# CURRENTLY NOT IN USE, THE EXCHANGE-ITEM MODEL MAY BE SCRAPPED

module Types
  class ExchangeItemType < Types::BaseObject
  	# These are fields of exchange_items
  	field :id, ID, null: true

  	# These are models with relations to ExchangeItem or their fields
  	field :exchange, Types::ExchangeType, null: true
  	field :item, Types::ItemType, null: true
  end
end
