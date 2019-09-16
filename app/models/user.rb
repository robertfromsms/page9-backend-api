class User < ApplicationRecord
	has_secure_password

	validates :user_name, presence: true, uniqueness: { case_sensitive: false }
  validates :full_name, presence: true
  validates :address, presence: true
  validates :password_digest, presence: true

	has_many :items

	def want_list
		buy_list = self.items.where(want_have_removed: "buy")
		sorted = buy_list.sort_by do |item| # I remember sorting can be done with activerecord/sql, I will refactor in the future
      item.created_at
    end
    sorted.reverse
	end

	def have_list
		have_list = self.items.where(want_have_removed: "sell")
		sorted = have_list.sort_by do |item| # I remember sorting can be done with activerecord/sql, I will refactor in the future
      item.created_at
    end
    sorted.reverse
	end

  # exchanges methods are not in use right now, keeping for future development

	def exchanges_as_seller
		exchanges_as_seller = Exchange.where(seller_ident: self.id).select do |exchange| 
			!(["confirmed", "rejected", "removed"].include?(exchange.exchange_status))
		end
    sorted = exchanges_as_seller.sort_by do |exchange| 
      exchange.created_at
    end
    sorted
	end

	def exchanges_as_buyer
		exchanges_as_buyer = Exchange.where(buyer_ident: self.id).select do |exchange| 
			!(["confirmed", "rejected", "removed"].include?(exchange.exchange_status))
		end
    sorted = exchanges_as_buyer.sort_by do |exchange| 
      exchange.created_at
    end
    sorted
	end

	def initiated_by_you
		initiated_by_you = Exchange.where(exchange_status: "initiated by " + self.user_name)
    sorted = initiated_by_you.sort_by do |exchange| 
      exchange.created_at
    end
    sorted
	end

  def initiated_by_others
    initiated_by_others = (Exchange.where(seller_ident: self.id) + Exchange.where(buyer_ident: self.id)).select do |exchange|
      exchange.exchange_status.split(" ")[0] == "initiated" && exchange.exchange_status.split(" ").last != self.user_name
    end
    sorted = initiated_by_others.sort_by do |exchange| 
      exchange.created_at
    end
    sorted
  end

  def past_exchanges
    past_exchanges = (Exchange.where(seller_ident: self.id) + Exchange.where(buyer_ident: self.id)).select do |exchange|
      ["confirmed", "rejected", "removed"].include?(exchange.exchange_status)
    end
    sorted = past_exchanges.sort_by do |exchange| 
      exchange.created_at
    end
    sorted
  end

  def want_list_matches
    user_want_list = self.want_list
    complete_have_list = Item.all.where(want_have_removed: "sell")

    matches = (user_want_list.map do |wantitem|
      complete_have_list.where.not(user_id: self.id).where(product_id: wantitem.product_id, additional_info: wantitem.additional_info)
    end).flatten.uniq

    sorted = matches.sort_by do |item|
      item.user_id
    end
    sorted
  end

  def have_list_matches
    user_have_list = self.have_list
    complete_want_list = Item.all.where(want_have_removed: "buy")

    matches = (user_have_list.map do |haveitem|
      complete_want_list.where.not(user_id: self.id).where(product_id: haveitem.product_id, additional_info: haveitem.additional_info)
    end).flatten.uniq

    sorted = matches.sort_by do |item|
      item.user_id
    end
    sorted
  end

	# Relationship from a seller to his buyers or a buyer to his sellers?
end
