# This handles everything related to JWT

class JsonWebToken
	def self.encode(payload)
		payload.reverse_merge!(meta)

		if ENV["SECRET_KEY_BASE"]
			secret = ENV["SECRET_KEY_BASE"] # key on heroku through environment variables
		else
			secret = Rails.application.secrets.secret_key_base # key locally
		end

		JWT.encode(payload, secret)
	end

	def self.decode(token)

		if ENV["SECRET_KEY_BASE"] 
			secret = ENV["SECRET_KEY_BASE"] # key on heroku through environment variables
		else
			secret = Rails.application.secrets.secret_key_base # key locally
		end

		JWT.decode(token, secret)
	end

	def self.valid_payload(payload)
		if expired(payload) || payload['iss'] != meta[:iss]
			return false
		else
			return true
		end
	end

	def self.meta
		{
			exp: 7.days.from_now.to_i, # jwt expires in 1 week
			iss: "Robert Chen, Ben Dill and Daniel Brice"
		}
	end

	def self.expired(payload)
		Time.at(payload['exp']) < Time.now
	end
end