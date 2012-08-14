doors = Array.new(100)
doors.fill(0) # each door is closed to start

1.upto(100) do |pass|
  i = pass
  while i<=100
    doors[i-1] = 1 - doors[i-1].to_i
    i = i+pass
  end
end

total = doors.inject(:+)
do_open = total > 50 ? 0 : 1

puts "The following doors are #{do_open ? "open" : "closed"}:"
1.upto(100) do |i|
  print "#{i} " if doors[i-1] == do_open
end
puts "\nThe rest are #{do_open ? "closed" : "open"}"

__END__

Here are the full results: 

0.upto(9) do |i|  
  0.upto(9) do |j|
    print doors[i*10+j] == 0 ? 'closed ' : 'open   '
  end
  puts
end

open   closed closed open   closed closed closed closed open   closed 
closed closed closed closed closed open   closed closed closed closed 
closed closed closed closed open   closed closed closed closed closed 
closed closed closed closed closed open   closed closed closed closed 
closed closed closed closed closed closed closed closed open   closed 
closed closed closed closed closed closed closed closed closed closed 
closed closed closed open   closed closed closed closed closed closed 
closed closed closed closed closed closed closed closed closed closed 
open   closed closed closed closed closed closed closed closed closed 
closed closed closed closed closed closed closed closed closed open   
