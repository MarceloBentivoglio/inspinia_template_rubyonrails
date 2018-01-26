# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Cleaning database...'
User.destroy_all
Client.destroy_all


puts 'Creating new Client...'
client = Client.create!(name: 'MVP Invest', cnpj: '23198636000195', available_funds_cents: 1000000)

puts 'Creating new User...'
user = User.create!(client: client, email: 'test@email.com', password: '123456')

# puts 'Creating new Sellers...'
# seller = Seller.create!(identification_number: "12254565000198", company_name: "Le Wagon School", client_id: 1)
# seller = Seller.create!(identification_number: "25462169000165", company_name: "Enterprise RH Ltda", client_id: 1)


# puts 'Creating new Operation'
# operation = Operation.create!(seller_id: 1, closure_date: Time.now, total_value_cents: 12000, average_outstanding_days: 38)

# puts 'Creating new Invoices...'


puts 'If you are reading this... your login details is'
puts 'test@email.com'
puts 'password: 123456'

puts 'THANKS :*'
