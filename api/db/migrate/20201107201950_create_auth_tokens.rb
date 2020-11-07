class CreateAuthTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :auth_tokens, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
