# the info of related info, such as an item's product name is not an attribute of the item
# This is so-called single source of truth, but creates additional linear dependence.
# For N items, if you wanted the item's product name and other attributs such as price,
# it would be "2N" "loads", performance can be improved by not doing single source of
# truth, the jury is still out.

module Types
  class ItemType < Types::BaseObject

  	# These are fields of Item
    field :id, ID, null: true
  	field :want_have_removed, String, null: true
  	field :listing_price, Float, null: true
  	field :additional_info, String, null: true
    field :user_id, Integer, null: true

  	# These are models with relations to Types or their fields
  	field :product_name, String, null: true
  	field :product_outside_ident, String, null: true
  	field :product_image_path, String, null: true
    field :user, Types::UserType, null: true
    
  end
end
