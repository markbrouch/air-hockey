# frozen_string_literal: true

module Mutations
  class AuthenticateWithFacebook < Mutations::BaseMutation
    graphql_name 'AuthenticateWithFacebook'

    argument :token, String, required: true

    field :user, Types::UserType, null: false
    field :token, String, null: false

    def resolve(args)
      facebook_user = Koala::Facebook::API.new(args[:token]).get_object(:me, fields: %i[email first_name last_name])

      user = User.find_or_create_by!(email: facebook_user['email']) do |new_user|
        new_user.first_name = facebook_user['first_name']
        new_user.last_name = facebook_user['last_name']
      end

      auth_token = AuthToken.create!(user: user)

      context[:auth_token] = auth_token
      context[:current_user] = user

      { user: user, token: auth_token.to_jwt, errors: [] }
    rescue Koala::Facebook::APIError => e
      raise GraphQL::ExecutionError, e.fb_error_message
    end
  end
end
