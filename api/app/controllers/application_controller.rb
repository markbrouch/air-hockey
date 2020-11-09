# frozen_string_literal: true

class ApplicationController < ActionController::API
  def auth_header
    request.headers['Authorization']
  end
end
