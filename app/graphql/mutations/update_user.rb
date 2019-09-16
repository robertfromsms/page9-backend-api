# this handles all user updates, full_name, address and email

class Mutations::UpdateUser < Mutations::BaseMutation
  argument :full_name, String, required: false
  argument :address, String, required: false
  argument :email, String, required: false

  field :user, Types::UserType, null: true
  field :errors, String, null: true
  field :message, String, null: true

  def resolve(full_name:nil, address:nil, email:nil)
    if full_name
      full_name_hash = {full_name: full_name}
    else
      full_name_hash = {}
    end
    if address
      address_hash = {address: address}
    else
      address_hash = {}
    end
    if email
      email_hash = {email: email}
    else
      email_hash = {}
    end
    update_arguments = full_name_hash.merge(address_hash).merge(email_hash)
    user = context[:current_user]
    
    if user.update(update_arguments)
      {
        user: user,
        message: 'Sucessful Update',
        errors: '',
        status: :updated
      }
    else
      {
        user: nil,
        message: '',
        errors: 'Unsucessful Update',
        status: :not_acceptable
      }
    end
  end
end