# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    decode_token(token)
  end

  def current_user
    return unless decoded_token

    auth_token = AuthToken.find_by_id(decoded_token[0]['id'])

    return unless auth_token

    auth_token.user
  end
end
