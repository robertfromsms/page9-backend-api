# CURRENTLY NOT IN USE, KEPT FOR FUTURE DEVELOPMENT. I was thinking about a specific
# mutation for updating email, because i wanted to implement email confirmation on
# sign up and also when updating email.

class Mutations::UpdateUserEmail < Mutations::BaseMutation
  # Maybe later, when I can implement email verification
  # argument :full_name, String, required: false
  # argument :address, String, required: false

  # field :user, Types::UserType, null: true
  # field :errors, String, null: true
  # field :message, String, null: true

  def resolve(full_name:nil, address:nil)
    # if full_name
    #   full_name_hash = {full_name: full_name}
    # else
    #   full_name_hash = {}
    # end
    # if address
    #   address_hash = {address: address}
    # else
    #   address_hash = {}
    # end
    # update_arguments = full_name_hash.merge(address_hash)
    # user = context[:current_user]
    
    # if user.update(update_arguments)
    #   {
    #     user: user,
    #     message: 'Sucessful Update',
    #     errors: '',
    #   }
    # else
    #   {
    #     user: nil,
    #     message: '',
    #     errors: 'Unsucessful Update'
    #   }
    # end
  end
end