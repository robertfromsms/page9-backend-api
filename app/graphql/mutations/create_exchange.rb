class Mutations::CreateExchange < Mutations::BaseMutation
  argument :seller_ident, Integer, required: false
  argument :buyer_ident, Integer, required: false

  field :exchange, Types::ExchangeType, null: true
  field :errors, String, null: true
  field :message, String, null: true

  def resolve(seller_ident: nil,buyer_ident: nil)
    user = context[:current_user]
    if !seller_ident && !buyer_ident
      {
        exchange: nil,
        message: '',
        errors: 'A seller or buyer id was not specified',
        status: :not_acceptable
      }
    elsif !seller_ident
      exchange = Exchange.new(seller_ident: user.id, buyer_ident: buyer_ident, exchange_status: "initiated by " + user.user_name)
      if exchange.save
        {
          exchange: exchange,
          message: 'Exchange successfully created',
          errors: '',
          status: :created
        }
      else
        {
          exchange: nil,
          message: '',
          errors: 'Exchange was not created',
          status: :not_acceptable
        }
      end
    elsif !buyer_ident
      exchange = Exchange.new(seller_ident: seller_ident, buyer_ident: user.id, exchange_status: "initiated by " + user.user_name)
      if exchange.save
        {
          exchange: exchange,
          message: 'Exchange successfully created',
          errors: '',
          status: :created
        }
      else
        {
          exchange: nil,
          message: '',
          errors: 'Exchange was not created',
          status: :not_acceptable
        }
      end
    end
  end
end