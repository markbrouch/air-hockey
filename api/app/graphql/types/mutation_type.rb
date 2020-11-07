module Types
  class MutationType < Types::BaseObject
    field :sign_out, mutation: Mutations::SignOut
    field :authenticate_with_facebook, mutation: Mutations::AuthenticateWithFacebook
  end
end
