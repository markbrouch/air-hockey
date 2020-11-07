module Types
  class UserType < Types::BaseObject
    graphql_name "User"

    implements GraphQL::Types::Relay::Node

    field :firstName, String, null: false, hash_key: :first_name

    field :lastName, String, null: false, hash_key: :last_name

    field :email, String, null: false
  end
end