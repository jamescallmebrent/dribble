dir = File.expand_path(File.join(File.dirname(__FILE__), '../..', 'lib'))
require File.join(dir, 'dribble')

# puts "Find Player's Shots by name"
# puts Dribble::API::Player.find('simplebits').inspect

puts
puts "Find Player's Profile"
player = Dribble::API::Player.profile('simplebits')
puts player

# puts
# puts "Find all the shots a player is following"
# puts Dribble::API::Player.following_shots('simplebits').inspect