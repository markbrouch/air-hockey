class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :profile_photo
      t.string :access

      t.timestamps
    end
  end
end