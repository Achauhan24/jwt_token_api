require 'jwt'
class JsonWebToken
	class << self
		def encode(payload,exp=2.hours.from_now)
			#set token expiration time
			payload[:exp]=exp.to_i
			#encode the user data eith secret key
			JWT.encode(payload,Rails.application.secrets.secret_key_base)
		end

		def decode(token)
			body=JWT.decode(token,Rails.application.secrets.secret_key_base)[0]
			HashWithIndifferentAccess.new body
		rescue
			nil
			
		end

	end
end