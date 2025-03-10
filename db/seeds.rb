# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Clear existing data
User.delete_all

# Create dummy users
50.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    campaigns_list: [
      { campaign_name: Faker::Lorem.word, campaign_id: Faker::Number.number(digits: 4) },
      { campaign_name: Faker::Lorem.word, campaign_id: Faker::Number.number(digits: 4) }
    ]
  )
end

puts "Created #{User.count} users"
