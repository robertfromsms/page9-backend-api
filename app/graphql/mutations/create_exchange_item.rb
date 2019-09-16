# NOT IN USE, KEEPING FOR FUTURE DEVELOPMENT, THIS MODEL MAY BE SCRAPPED

class Mutations::CreateExchangeItem < Mutations::BaseMutation
  argument :exchange_id, ID, required: true
  argument :item_id, ID, required: true

  field :exchange_item, Types::ExchangeItemType, null: true
  field :errors, String, null: true
  field :message, String, null: true

  def resolve(exchange_id:,item_id:)
    exchange_item = ExchangeItem.new(exchange_id: exchange_id, item_id: item_id)
    if exchange_item.save
      {
        exchange_item: exchange_item,
        message: 'Item added to the exchange',
        errors: '',
        status: :created
      }
    else
      {
        exchange: nil,
        message: '',
        errors: 'Item was not added to the exchange',
        status: :not_acceptable
      }
    end
  end
end