#require_relative lets you add/import other .rb files
#

require_relative 'player'
require_relative 'team'

player1 = Player.new("Bob", 13, 5)
player2 = Player.new("Jim", 15, 4.5)
player3 = Player.new("kim", 21, 5)
player4 = Player.new("Don", 14, 5)
player5 = Player.new("Con", 16, 3)

red_team = Team.new("Red")
red_team.add_players(player1, player2, player3, player4, player5) #splat

# This you can do with the team because you have included Enumerable in Team class and implemented each method
eligible_players = red_team.select {|player| (14..20) === player.age}
                           .reject {|player| player.skill_level < 4.5}

puts eligible_players
