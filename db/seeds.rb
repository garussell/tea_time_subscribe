# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed Customers
10.times do
  customer = Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.street_address
  )
  
  # Seed Subscriptions for each Customer
  2.times do
    customer.subscriptions.create(
      title: Faker::Commerce.product_name,
      price: Faker::Commerce.price,
      status: Subscription.statuses.keys.sample,
      frequency: Faker::Lorem.word
      )
    end
  end
  
puts "Created #{Customer.count} customers"
puts "Created #{Subscription.count} subscriptions"

# Seed Teas for each Subscription
Subscription.all.each do |subscription|
  3.times do
    subscription.teas.create(
      title: Faker::Tea.variety,
      description: Faker::Lorem.sentence,
      temperature: Faker::Number.between(from: 70.0, to: 100.0),
      brew_time: Faker::Number.between(from: 2, to: 5)
    )
  end
end

puts "Created #{Tea.count} teas"