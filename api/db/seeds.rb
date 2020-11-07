# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CSV.foreach(Rails.root.join('lib/seeds/users.csv'), headers: true) do |row|
  User.find_or_create_by(email: row['email']) do |user|
    user.first_name = row['name']
    user.last_name = row['Surname']
    user.email = row['email']
    user.profile_photo = row['image']
    user.access = row['access']
    user.save

    puts "#{user.email} saved"
  end
end

puts "There are now #{User.count} rows in the users table"