# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

file = File.read('db/AllSets.json')
all_sets_hash = JSON.parse(file)
all_sets_code_and_size_array = []
all_sets_hash.each do |setName, setInfo|
	all_sets_code_and_size_array.push({code: setName, set_name: setInfo["name"], size: setInfo["baseSetSize"]})
end
real_sets_code_and_size_array = all_sets_code_and_size_array.select do |set| 
	set[:size]!=0
end

40.times do
	fakename = Faker::Name.name
	User.create(
		user_name: fakename.split(" ").join("").downcase + rand(0..1000).to_s,
		full_name: fakename,
		address: Faker::Address.full_address,
		password: "1234",
		account_status: "confirmed",
		email: Faker::Internet.email(name: fakename),
		seller_score: 0,
		buyer_score: 0
	)
end

500.times do
	set = real_sets_code_and_size_array[rand(0...real_sets_code_and_size_array.length)]
	set_name = set[:code]
	set_number = rand(1..set[:size]).to_s
	outside_ident = set_name + " " + set_number

	if Product.find_by(outside_ident: outside_ident)
      	puts "already exist"
    else
      	outside_card = MTG::Card.where(set: set_name).where(number: set_number).all[0]
	    if !outside_card
	  		puts "Oh no!" 
	  	else
	  		card = Product.new(name: outside_card.name, outside_ident: outside_ident, img_path: outside_card.image_url)
			if card.save
		      puts "Success!"
		    else
		      puts "Oh no!"
		    end
	  	end
    end
end

1500.times do
	buyer_id = rand(0..39)
	seller_id = (buyer_id / 2) + 1
	product_id = rand(0...Product.all.length)
	
	Item.create(
		product_id: product_id,
		want_have_removed: "sell",
		listing_price: rand(1..100),
		user_id: seller_id,
		additional_info: "normal nearMint"
	)

	Item.create(
		product_id: product_id,
		want_have_removed: "buy",
		user_id: buyer_id,
		additional_info: "normal nearMint"
	)
end


# all_items_to_sell = Item.all.select { |item| item.want_have_removed == "sell"}

# all_items_to_sell.each do |item|
# 	seller_id = item.user_id
# 	buyer_id = (seller_id - 1)*2
# 	exchange_status = Faker::Boolean.boolean ? "SellStart" : "BuyStart"

# 	the_exchange = Exchange.create(
# 		seller_ident: seller_id,
# 		buyer_ident: buyer_id,
# 		exchange_status: exchange_status
# 	)

# 	ExchangeItem.create(
# 		exchange_id: the_exchange.id,
# 		item_id: item.id
# 	)
# end
	

