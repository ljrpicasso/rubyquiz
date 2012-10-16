require 'rspec'

class Matcher

  def self.match? text
    # maybe controversial, but if no brackets, it is balanced...
    return true if text.empty?

    # first test is simple - unequal number of []'s
    return false if Matcher.miscount text

    # second test - look for mismatched levels of depth
    depth_sq = depth_pa = depth_cu = 0
    text.each_char do |c| 
      depth_sq -=  1 if c == ']' and depth_sq > 0
      depth_sq +=  1 if c == '['
      depth_pa -=  1 if c == ')' and depth_pa > 0
      depth_pa +=  1 if c == '('
      depth_cu -=  1 if c == '}' and depth_cu > 0
      depth_cu +=  1 if c == '{'
    end

    return depth_sq == 0 &&
           depth_pa == 0 &&
           depth_cu == 0
  end

  def self.miscount t = @text
    left = Matcher.count '[{(', t
    right = Matcher.count ']})', t
    left != right
  end

  def self.count ch, t
    t.to_s.count ch
  end
end


describe :Matcher do

  it 'will match correct combinations of brackets' do
    match_list = [
      '',
      '[]',
      '[][][[]]',
      '{(s)[f,u,n]}',
      '[]{}()',
    ]
    match_list.each do |text|
      Matcher.match?(text).should be_true
    end
  end

  it 'will not match mismatched brackets' do
    match_list = [
      ']',
      '[[))',
      '[][][[[]]',
      '}{)(]['
    ]
    match_list.each do |text|
      Matcher.match?(text).should be_false
    end
  end

end


if __FILE__ == $0

  match_list = [
    '*',
    '[]',
    '][][',
    '][][[]',
    ']]][[[][',
    '][]*[][][[',
    '][[][]]]][[[',
    ']][][[{*}][][[',
    '[][[][][[]()]][]',
    '[[[[()]][[][]]][]]',
    '[[*][]][][[]]]*[][]]',
    '[[]',
    '[]]',
  ]

  match_list.each do |text|
    puts "#{Matcher.match?(text) ? 'OK:  ' : 'bad: '}#{text}"
  end
end
