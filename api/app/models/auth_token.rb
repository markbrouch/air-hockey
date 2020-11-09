# frozen_string_literal: true

class AuthToken < ApplicationRecord
  belongs_to :user
  validates_presence_of :user

  def self.find_by_jwt(jwt)
    decoded_token = JsonWebToken.decode_token(jwt)
    return unless decoded_token

    find_by_id(decoded_token[0]['id'])
  end

  def to_jwt
    JsonWebToken.encode_token(id: id)
  end
end
