module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    # This handles all updates to user
    field :update_user, mutation: Mutations::UpdateUser

    # This handles email updates to user
    # field :update_user_email, mutation: Mutations::UpdateUserEmail

  	# this handles updating an item info
  	field :update_item_info, mutation: Mutations::UpdateItemInfo    

  	# this handles creating an item
  	field :create_item, mutation: Mutations::CreateItem

  	# this handles creating exchanges
  	field :create_exchange, mutation: Mutations::CreateExchange

    # this handles editing (and deleting) exchanges
    field :update_exchange, mutation: Mutations::UpdateExchange

    # this handles creating exchange_items
    field :create_exchange_item, mutation: Mutations::CreateExchangeItem
  end
end
