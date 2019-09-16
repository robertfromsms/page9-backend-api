module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    # Real code begins here
    # This implementation of querying where you can query for any number of users by id
    # If you want to query for 1 user, put it in an array, if you want to query for all
    # just dont put anything in. Put in -1 for the current user.
    # most common query is querying for the current user, then everything related to 
    # the current user.
    field :users, [Types::UserType], null: false do
      argument :id_list, [Integer], required: false
    end

    def users(id_list: nil)
      if id_list == nil
        User.all
      elsif id_list[0] == -1
        [context[:current_user]]
      else
        User.where(id: id_list)
      end
    end

    # This generates the combined want list of all users, this query will probably be removed
    # in the future
    field :complete_want_list, [Types::ItemType], null: false

    def complete_want_list
      complete_want_list = Item.all.select { |item| item.want_have_removed == "buy"}
      complete_want_list
    end

    # This generates the combined have list of all users, this query will probably be removed
    # in the future
    field :complete_have_list, [Types::ItemType], null: false

    def complete_have_list
      complete_have_list = Item.all.select { |item| item.want_have_removed == "sell"}
      complete_have_list
    end
  end
end
