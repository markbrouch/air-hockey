class AddUserAgentToAuthToken < ActiveRecord::Migration[6.0]
  def change
    add_column :auth_tokens, :user_agent, :string
  end
end
