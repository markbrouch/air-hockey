# frozen_string_literal: true

class AuthToken < ApplicationRecord
  include JsonWebToken

  belongs_to :user
  validates_presence_of :user

  def to_s
    encode_token(id: id)
  end
end
