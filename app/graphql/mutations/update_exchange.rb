# NOT IN USE, KEPT FOR FUTURE DEVELOPMENT

class Mutations::UpdateExchange < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :exchange_status, String, required: true

  field :exchange, Types::ExchangeType, null: true
  field :errors, String, null: true
  field :message, String, null: true

  def resolve(id:, exchange_status:)
    exchange = Exchange.find_by(id: id)

    if exchange.update(exchange_status: exchange_status)
      {
        exchange: exchange,
        message: 'Exchange updated sucessfully',
        errors: '',
        status: :updated
      }
    else
      {
        exchange: nil,
        message: '',
        errors: 'Exchange was not updated',
        status: :not_acceptable
      }
    end
  end
end