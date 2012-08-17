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

  def open
    @open = true
    puts "   Behind door #{@my_id} is... a #{@content}" if VERBOSE
  end

  def is_open?
    @open
  end

  def is_goat?
    @content == 'goat'
  end

  def is_car?
    @content == 'car'
  end

  def contents
    @content == nil ? "nothing" : @content
  end
end

class Player
  attr_accessor :name

  def initialize( name )
    @name = name
    puts "Welcome, #{@name}" if VERBOSE
  end

end

class LetsMakeADeal
  attr_accessor :player, :doors

  def initialize( player, doors )
    @player = player
    @doors = doors
    @prng_doors = Random.new
    @prng_player = Random.new
  end

  def spin
    return @prng_doors.rand(1..3)
  end

  def pick_door
    return @prng_player.rand(1..3)
  end

  def montys_turn( player_door )
    # if player picked a car, doesn't matter what Monty picks
    puts "----- Player selected door #{player_door}"
    if @doors[player_door-1].is_car?
      puts "----- That door was a car!"
      case player_door
      when 1, 3
        md = 2
      else
        md = 1
      end
    else # Monty will pick the other goat door
      puts "----- That door was a goat"
      case player_door
      when 1
        md = 2 if @doors[2].is_car?
        md = 3 if @doors[1].is_car?
      when 2
        md = 3 if @doors[0].is_car?
        md = 1 if @doors[2].is_car?
      when 3
        md = 2 if @doors[0].is_car?
        md = 1 if @doors[1].is_car?
      end
    end
    puts "Monty makes his selection. And..." if VERBOSE
    puts "----- Monty picked #{md}"
    @doors[md-1].open
  end

  def play
    cd = spin
    1.upto(3) do |i|
      case i
        when cd
          @doors[i-1].set_content('car')
        else
          @doors[i-1].set_content('goat')
      end
      puts "Assigned #{@doors[i-1].contents} to door #{i}" if VERBOSE
    end

    # Player chooses the first door to open
    pd = pick_door
    @doors[pd-1].open

    # Now, Monty chooses which door he'll show
    montys_turn( pd )

    # Player decides to keep or switch
    
    # And a winner is determined ;-)
  
  end
end

if __FILE__ == $0
  @player = Player.new("Mikey")
  @doors = []
  (1..3).each do |d|
    door = Door.new(d)
    @doors << door
  end
  @game = LetsMakeADeal.new( @player, @doors )
  @game.play
end

#-------------------------------
# Tests
#-------------------------------

describe LetsMakeADeal do

  before do
    @player = Player.new("Mikey")
    @doors = []
    (1..3).each do |d|
      door = Door.new(d)
      @doors << door
    end
    @game = LetsMakeADeal.new( @player, @doors )
  end

  it 'has appropriate game pieces' do
    @game.player.name.should == "Mikey"
    @game.doors.size.should == 3
    @game.doors[0].is_open?.should be_false
    @game.doors[1].is_open?.should be_false
    @game.doors[2].is_open?.should be_false
  end

  it 'can spin for a random door number' do
    5.times { @game.spin.should be_between(1,3) }
  end
end

describe Door do

  before do
    @door = Door.new(1)
  end

  it 'starts closed' do
    @door.is_open?.should be_false
  end

  it 'has no default contents' do
    @door.contents.should == "nothing"
  end

  it 'can be opened' do
    @door.open
    @door.is_open?.should be_true
  end

  it 'can be used and reset' do
    @door.set_content('goat')
    @door.is_goat?.should be_true
    @door.open
    @door.set_content(nil)
    @door.is_open?.should be_false
    @door.contents.should == "nothing"
  end

  it 'can have a goat or a car' do
    @door.set_content('goat')
    @door.contents.should == 'goat'
    @door.is_goat?.should be_true
    @door.is_car?.should be_false

    @door.set_content('car')
    @door.contents.should == 'car'
    @door.is_goat?.should be_false
    @door.is_car?.should be_true
  end
end

describe Player do

  before do
    @player = Player.new("Mikey")
  end

  it 'has a name' do
    @player.name.should == "Mikey"
  end
end
