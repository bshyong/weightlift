# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'DEFAULT USERS'
user = User.create! :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name

puts 'DEFAULT QUOTES'
[ "If it doesn't challenge you, it doesn't change you.",
  "Success is the sum of many small actions.",
  "Respect the training. Honor the commitment. Cherish the results.",
  "Strong is what happens when you run out of weak."
].each do |q|
    quote = Quote.create! :content => q
    puts 'quote: ' << quote.content
end