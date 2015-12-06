# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times { FactoryGirl.create(:user) }
1.times { FactoryGirl.create(:admin) }
1.times { FactoryGirl.create(:standard) }
50.times { FactoryGirl.create(:post, :with_comments) }
# 100.times { FactoryGirl.create(:comment) }

puts "Finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
