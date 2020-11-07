# frozen_string_literal: true

module JsonWebToken
  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def decode_token(token)
    JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
  rescue JWT::DecodeError
    nil
  end
end
