#!/usr/bin/env ruby
require 'rspec'


def check_type( a )
	# check for card type
	type = :unknown
	case a[0..1] 
	  when '34', '37'
		type = :amex if a.length == 15
	  when '51'..'55'
		type = :master if a.length == 16
	  when '40'..'49'
		type = :visa if a.length == 13 or a.length == 16
	  when '60'
		if a[2..3] == '11'
		  type = :discover if a.length == 16
		end
	end
  type
end

def is_valid?( a )
	arr = []
	a.each_char {|c| arr << c }
	arr.reverse!
	sum = 0
	flip = 1
	arr.each { |c|
	  if c.to_i*flip < 10
	    sum += c.to_i*flip
	  else
	    sum += 1 + (c.to_i*flip - 10)
	  end
	  flip = 3-flip
	}
	sum % 10 == 0
end

ARGV.each do|a|
  puts "Argument: #{a}"
  
  type = check_type( a )
  if type != :unknown
  	if is_valid?(a)
  		puts 'Valid Card'
  	else
  		puts 'Call the police!'
  	end 
  end
  puts type	
end






describe 'credit card can be determined' do

it 'knows mastercard' do
  check_type( '5100000000000000' ).should == :master
  check_type( '5200000000000000' ).should == :master
  check_type( '5300000000000000' ).should == :master
  check_type( '5400000000000000' ).should == :master
end

it 'knows discover' do
  check_type( '6011000000000000' ).should == :discover
end

it 'knows visa' do
  check_type( '4000000000000000' ).should == :visa
  check_type( '4000000000000' ).should == :visa
end

it 'knows amex' do
  check_type( '340000000000000' ).should == :amex
  check_type( '370000000000000' ).should == :amex
end

it 'knows dummies' do
  check_type( '5000000000000000' ).should == :unknown
  check_type( '520000000000' ).should == :unknown
  check_type( 'a').should == :unknown 
end

end

describe 'credit card validation' do

it 'knows valid cc numbers' do
	is_valid?('4408041234567893').should be_true
	is_valid?('5490363763968433').should be_true
end

it 'knows invalid cc numbers' do
	is_valid?('4417123456789112').should be_false
end

end