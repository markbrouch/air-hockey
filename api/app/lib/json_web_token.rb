# frozen_string_literal: true
module JsonWebToken
  def self.encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def self.decode_token(token)
    JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
  rescue JWT::DecodeError
    nil
  end
end