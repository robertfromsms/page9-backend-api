# CURRENT NOT IN USE, KEPT FOR FUTURE DEVELOPMENT

module Types
  class ExchangeType < Types::BaseObject

  	# These are fields of Exchanges
  	field :id, ID, null: true
  	field :seller_ident, ID, null: true
  	field :buyer_ident, ID, null: true
  	field :exchange_status, String, null: true
  	field :created_at, GraphQL::Types::ISO8601DateTime, null: true

  	# These are models with relations to Exchanges or their fields
    field :buyer, Types::UserType, null: true
    field :seller, Types::UserType, null: true
  	field :exchange_items, [Types::ExchangeItemType], null: true
  end
end
