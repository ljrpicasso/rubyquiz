require 'rspec'

=begin
Langton's ant models an ant sitting on a plane of cells, all of 
which are white initially, facing in one of four directions. 
Each cell can either be black or white. The ant moves according 
to the color of the cell it is currently sitting in, with the 
following rules:

* If the cell is black, it changes to white and the ant turns left;
* If the cell is white, it changes to black and the ant turns right;
* The Ant then moves forward to the next cell, and repeat from step 1.

This rather simple ruleset leads to an initially chaotic movement 
pattern, and after about 10000 steps, a cycle appears where the ant 
moves steadily away from the starting location in a diagonal corridor 
about 10 pixels wide. Conceptually the ant can then travel to infinitely 
far away.

For this task, start the ant near the center of a 100 by 100 field of 
cells, which is about big enough to contain the initial chaotic part of 
the movement. Follow the movement rules for the ant, terminate when it 
moves out of the region, and show the cell colors it leaves behind.
=end


North = [0,1]
East = [1,0]
South = [0,-1]
West = [-1,0]
White = 0
Black = 1

class Ant
  def initialize
    @myRow = -1
    @myCol = -1
  end
  def location
    return [@myRow, @myCol]
  end
  def move_to( row, col )
    @myRow = row
    @myCol = col
  end
end

class Farm
  def initialize( x_size=100, y_size=100 )
    @farm = Array.new(x_size) { |i| Array.new(y_size) { |i| White }}
  end

  def white( r, c )
    @farm[r-1][c-1] = White
  end
  def white?( r, c )
    @farm[r-1][c-1] == White
  end
  def black( r, c )
    @farm[r-1][c-1] = Black
  end
  def black?( r, c )
    @farm[r-1][c-1] == Black
  end
end


