# CURRENTLY ONLY USED TO "REMOVE" A CARD. There is no way to delete an item from the database.
# BTW, an item represents a specific instance of a magic card, a product is the idea of a 
# specific magic card. I decided to not allow item deletion because there may potentially
# be a situation where an exchange linking to a deleted item exist, and that's a big no no.

class Mutations::UpdateItemInfo < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :listing_price, Float, required: false
  argument :additional_info, String, required: false
  argument :want_have_removed, String, required: false

  field :item, Types::ItemType, null: true
  field :errors, String, null: true
  field :message, String, null: true

  def resolve(id:, listing_price:nil, additional_info:nil, want_have_removed:nil)
    update_arguments = {}
    update_arguments[:listing_price] = listing_price if listing_price
    update_arguments[:additional_info] = additional_info if additional_info
    update_arguments[:want_have_removed] = want_have_removed if want_have_removed
    user = context[:current_user]
    item = Item.find_by(id: id)
    if item.user.id != user.id
      {
        item: nil,
        message: '',
        errors: 'You do not have access to edit this item',
        status: :not_acceptable
      }
    elsif item.want_have_removed != "buy" && item.want_have_removed != "sell"
      {
        item: nil,
        message: '',
        errors: 'The item status does not permit editing',
        status: :not_acceptable
      }
    elsif item.want_have_removed == "buy" && listing_price
      {
        item: nil,
        message: '',
        errors: 'This wantlist item cannot have a listing price',
        status: :not_acceptable
      }
    elsif item.update(update_arguments)
      {
        item: item,
        message: 'Sucessful Update',
        errors: '',
        status: :updated
      }
    else
      {
        item: nil,
        message: '',
        errors: 'Unsucessful Update'
      }
    end
  end
end