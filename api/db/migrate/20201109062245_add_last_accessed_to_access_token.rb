class AddLastAccessedToAccessToken < ActiveRecord::Migration[6.0]
  def change
    add_column :auth_tokens, :last_accessed_at, :datetime
  end
end
