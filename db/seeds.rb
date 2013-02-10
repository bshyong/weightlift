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
user = User.find_or_create_by(:username => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup)
puts 'user: ' << user.username

puts 'DEFAULT QUOTES'
[ "If it doesn't challenge you, it doesn't change you.",
  "Success is the sum of many small actions.",
  "Respect the training. Honor the commitment. Cherish the results.",
  "Strong is what happens when you run out of weak."
].each do |q|
    quote = Quote.find_or_create_by(:content => q)
    puts 'quote: ' << quote.content
end

puts 'DEFAULT LIFTS AND REPS'
require 'open-uri'
require 'nokogiri'
url = "https://spreadsheets.google.com/feeds/list/0AhERslPRRahKdFl6UFZoQTh2UVdXLXBPTDlVS1dqanc/od6/public/basic"
doc = Nokogiri::XML(open(url))
doc.remove_namespaces!
@rows = []
@total_weight = 0
puts doc.xpath('/feed/entry/content').length.to_s + "total elements"
doc.xpath('/feed/entry/content').each do |x|
    content = x.children()[0].content().split(',').collect{|d| d.split(':')[1].strip}
    @rows << (content << content[1].to_i*content[2].to_i)
    @total_weight += content[1].to_i*content[2].to_i
end

@rows.each do |r|
    lift = Lift.find_or_create_by(name: r[0])
    puts 'lift: ' << lift.name
    r = User.first.reps.create(weight: r[1], count: r[2])
    lift.reps << r
    puts "rep: #{r.count} reps @ #{r.weight} lbs"
end

