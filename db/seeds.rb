# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# FactoryGirl.create(:user)
FactoryGirl.create(:admin)
FactoryGirl.create(:category)
FactoryGirl.create(:post)
FactoryGirl.create(:comment)

puts "Finished"
puts "#{User.count} users created"
puts "#{Category.count} categories created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
