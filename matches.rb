require 'rspec'

class Matcher
  attr_accessor :text

  def initialize
    @text = ''
  end

  def match?
    # maybe controversial, but if no brackets, it is balanced...
    return true if @text.empty?

    # first test is simple - unequal number of []'s
    return false if Matcher.miscount @text

    # second test - look for mismatched levels of depth
    depth = 0
    @text.each_char do |c| 
      depth = depth - 1 if c == ']' and depth > 0
      depth = depth + 1 if c == '['
    end

    return depth == 0
  end

  def self.match text
    # maybe controversial, but if no brackets, it is balanced...
    return true if text.empty?

    # first test is simple - unequal number of []'s
    return false if Matcher.miscount text

    # second test - look for mismatched levels of depth
    depth = 0
    text.each_char do |c| 
      depth = depth - 1 if c == ']' and depth > 0
      depth = depth + 1 if c == '['
    end

    return depth == 0
  end

  def self.miscount t = @text
    left = Matcher.count '[', t
    right = Matcher.count ']', t
    left != right
  end

  def self.count ch, t
    t.to_s.count ch
  end
end

describe "matcher" do

  it 'will match correct combinations of brackets' do
    m = Matcher.new
    match_list = [
      '',
      '[]',
      '[][][[]]',
    ]
    match_list.each do |text|
      m.text = text
      m.match?.should be_true
    end
  end

  it 'will not match mismatched brackets' do
    m = Matcher.new
    match_list = [
      ']',
      '[[',
      '[][][[[]]',
      '[[[[['
    ]
    match_list.each do |text|
      m.text = text
      m.match?.should be_false
    end
  end

  it 'can be called on the class' do
    match_list = [
      '',
      '[]',
      '[][][[]]',
    ]
    match_list.each do |text|
      Matcher.match(text).should be_true
    end

    match_list = [
      ']',
      '[[',
      '[][][[[]]',
      '[[[[['
    ]
    match_list.each do |text|
      Matcher.match(text).should be_false
    end
  end

end


if __FILE__ == $0

  m = Matcher.new
  match_list = [
    '[]',
    '][][',
    '][][[]',
    ']]][[[][',
    '][]][][][[',
    '][[][]]]][[[',
    ']][][[[]]][][[',
    '[][[][][[][]]][]',
    '[[[[[]]][[][]]][]]',
    '[[[][]][][[]]][[][]]',
    '[[]',
    '[]]',
  ]

  match_list.each do |text|
    m.text = text
    puts "#{m.match? ? 'OK:  ' : 'bad: '}#{text}"
  end
end
