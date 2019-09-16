# many fields are not in use, but they are kept for future development.

module Types
  class UserType < Types::BaseObject

  	# These are supposed to be parameters for querying
  	field :id_list, [Integer], null: false #Is this okay???

  	# These are fields of User
    field :id, ID, null: true
  	field :user_name, String, null: true
  	field :full_name, String, null: true
  	field :address, String, null: true
  	field :email, String, null: true

  	# These are models with relations to User or their fields
  	field :want_list, [Types::ItemType], null: true
  	field :have_list, [Types::ItemType], null: true
  	field :exchanges_as_seller, [Types::ExchangeType], null: true
  	field :exchanges_as_buyer, [Types::ExchangeType], null: true
    field :initiated_by_you, [Types::ExchangeType], null: true
    field :initiated_by_others, [Types::ExchangeType], null: true
    field :past_exchanges, [Types::ExchangeType], null: true
    field :want_list_matches, [Types::ItemType], null: true
    field :have_list_matches, [Types::ItemType], null: true

  end
end
