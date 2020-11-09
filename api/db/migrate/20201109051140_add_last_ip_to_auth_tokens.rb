class AddLastIpToAuthTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :auth_tokens, :last_ip, :string
  end
end
