# frozen_string_literal: true

module Mutations
  class SignOut < BaseMutation
    include JsonWebToken

    graphql_name 'SignOut'

    argument :token, String, required: true

    field :token, String, null: true

    def resolve(args)
      decoded_token = decode_token(args[:token])
      raise GraphQL::ExecutionError, 'Invalid token' unless decoded_token.present?

      token_id = decoded_token[0]['id']
      raise GraphQL::ExecutionError, 'Invalid token' unless token_id.present?

      AuthToken.find_by_id(token_id)&.destroy

      context[:current_user] = nil

      { token: nil, errors: [] }
    end
  end
end
