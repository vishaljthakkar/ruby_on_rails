class Team
  include Enumerable # built in module

  attr_accessor :name, :players

  def initialize(name)
    @name = name
    @players = []
  end

  def add_players(*more_players) #splat
    @players += more_players
  end

  def to_s
    "#{@name} team: #{@players.join(", ")}"
  end

  def each # This is the implementation of enumerable method
    @players.each {|player| yield player }
  end
end
