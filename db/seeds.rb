

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
      image: Faker::LoremFlickr.image,
      link: Faker::Internet.url
    )
  end
end

puts "Created #{Tea.count} teas"