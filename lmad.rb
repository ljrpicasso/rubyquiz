require 'rspec'

=begin 
This week's quiz is to run random simulations of the Let's Make a Deal
game.  Show the effects of a strategy of the contestant always keeping his first
guess so it can be contrasted with the strategy of the contestant always
switching his guess.

Let's Make a Deal was played as follows:

Suppose you're on a game show and you're given the choice of three doors.
Behind one door is a car; behind the others, goats. The car and the goats were
placed randomly behind the doors before the show. The rules of the game show are
as follows: After you have chosen a door, the door remains closed for the time
being. The game show host, Monty Hall, who knows what is behind the doors, now
has to open one of the two remaining doors, and the door he opens must have a
goat behind it. If both remaining doors have goats behind them, he chooses one
randomly. After Monty Hall opens a door with a goat, he will ask you to decide
whether you want to stay with your first choice or to switch to the last
remaining door. Imagine that you chose Door 1 and the host opens Door 3, which
has a goat. He then asks you "Do you want to switch to Door Number 2?" Is it to
your advantage to change your choice?

Note that the player may initially choose any of the three doors (not just
Door 1), that the host opens a different door revealing a goat (not
necessarily Door 3), and that he gives the player a second choice between the
two remaining unopened doors.

Simulate at least a thousand games using three doors for each strategy and
show the results in such a way as to make it easy to compare the effects of
each strategy.  
=end

VERBOSE = true

class Door
  def initialize(id)
    @open = false
    @content = nil
    @my_id = id
  end

  def set_content( item )
    @content = item
    #consider this a reset if item is passed in as nil
    @open = false if item == nil
  end

  def open_door
    @open = true
    puts "Behind door #{id} is... #{contents}" if VERBOSE
  end

  def open?
    @open
  end

  def contents
    @content == nil ? "nothing" : @content
  end
end

class Player
  def initialize( name )
    @name = name
    puts "Welcome, #{@name}" if VERBOSE
  end

end

class LetsMakeADeal
  def initialize( player, doors )
    @player = player
    @doors = doors
  end

  def spin
    return random(1..3)
  end
end

if __FILE__ == $0
  #t_start = Time.now
  #a = Anagrammer.new
  #a.start
  #puts "Total computation time: #{Time.now - t_start} seconds"
end

#-------------------------------


describe LetsMakeADeal do

  before do
    @player = Player.new
    @doors = []
    (1..3).each do |d|
      door = Door.new(d)
      @doors << door
    end
    @game = LetsMakeADeal.new( @player, @doors )
  end

  it 'has appropriate game pieces' 
  it 'can spin for a random door number'
end

describe Door do
  it 'starts closed'
  it 'has no default contents'
  it 'can be opened'
  it 'can be reset'
end

describe Player do
  it 'has a name'
end
