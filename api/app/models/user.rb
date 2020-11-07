# frozen_string_literal: true

class User < ApplicationRecord
  has_many :auth_tokens

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
