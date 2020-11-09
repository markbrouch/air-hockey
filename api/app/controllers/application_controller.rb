# frozen_string_literal: true

class ApplicationController < ActionController::API
  def auth_header
    request.headers['Authorization']
  end

  def auth_token
    return unless auth_header

    jwt = auth_header.split(' ')[1]
    AuthToken.find_by_jwt(jwt)
  end

  def current_user
    return unless auth_token

    auth_token.user
  end
end
