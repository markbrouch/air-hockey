# frozen_string_literal: true

module Mutations
  class SignOut < BaseMutation
    graphql_name 'SignOut'

    argument :token, String, required: true

    field :token, String, null: true

    def resolve(args)
      AuthToken.find_by_jwt(args[:token])&.destroy

      context[:auth_token] = nil
      context[:current_user] = nil

      { token: nil, errors: [] }
    end
  end
end
