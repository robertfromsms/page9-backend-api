class Mutations::CreateItem < Mutations::BaseMutation
  argument :set_and_number, String, required: true
  argument :want_have_removed, String, required: true
  argument :listing_price, Float, required: false
  argument :additional_info, String, required: true

  field :item, Types::ItemType, null: true
  field :errors, String, null: true
  field :message, String, null: true

  def resolve(want_have_removed:, listing_price:nil, additional_info: ,set_and_number:)
    if want_have_removed == "buy" && listing_price
      {
        item: nil,
        message: '',
        errors: 'A wantlist item cannot have a listing price',
        status: :not_acceptable
      }
    end
    user = context[:current_user]
    # user = User.find_by(id: 10)
    set = set_and_number.split(" ")[0]
    number = set_and_number.split(" ")[1]
    if Product.find_by(outside_ident: set_and_number) # Checks if the magic card already exist in database
      card = Product.find_by(outside_ident: set_and_number)
      item = Item.new(product_id: card.id, want_have_removed: want_have_removed, listing_price: listing_price, additional_info: additional_info, user_id: user.id)
      if item.save
        {
          item: item,
          message: 'item created sucessfully',
          errors: '',
          status: :created
        }
      else
        {
          item: nil,
          message: '',
          errors: 'item was not created',
          status: :not_acceptable
        }
      end
    else #If the card doesnt exist, we use the third party api to obtain the required info and create the card in the database
      outside_card_array = MTG::Card.where(set: set).where(number: number).all
      if outside_card_array.length != 0 
        outside_card = outside_card_array[0]  
        card = Product.new(name: outside_card.name, outside_ident: set_and_number, img_path: outside_card.image_url)
      else #If the card is not found, usually due to user input errors, we instantiate a blank card, which will fail to save
        card = Product.new 
      end
      if card.save
        item = Item.new(product_id: card.id, want_have_removed: want_have_removed, listing_price: listing_price, additional_info: additional_info, user_id: user.id)
        if item.save
          {
            item: item,
            message: 'item created sucessfully',
            errors: '',
            status: :created
          }
        else
          {
            item: nil,
            message: '',
            errors: 'item was not created',
            status: :not_acceptable
          }
        end
      else
        {
          item: nil,
          message: '',
          errors: 'item was not created',
          status: :not_acceptable
        }
      end
    end
  end
end