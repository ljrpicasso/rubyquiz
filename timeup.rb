require 'time'
require "rspec"

def seconds_fraction_to_time(seconds)
  days = hours = mins = 0
    mins = (seconds / 60).to_i
    seconds = (seconds % 60 ).to_i
    hours = (mins / 60).to_i
    mins = (mins % 60).to_i
    days = (hours / 24).to_i
    hours = (hours % 24).to_i
  return [days,hours,mins,seconds]
end
  
def show_uptime( t )
  now = Time.now
  
  d, h, m, s = seconds_fraction_to_time(now - t)
  case d
  when 0
    days = ""
  when 1
    days = "1 day, "
  else
    days = "#{d} days, "
  end
   
  "Uptime is #{days}#{h} hours and #{m} minutes"
end

begin
  boot_time1 = Time.at(`sysctl -b kern.boottime 2>/dev/null`.unpack('L').first)
  puts "\nLast reboot: #{boot_time1.asctime}"
  puts show_uptime( boot_time1 )
  boot_time2 = Time.parse(`who -b 2>/dev/null`)
  puts show_uptime( boot_time2 )
end


describe "valid time output" do

  it "should handle a short period (minutes)" do
    t1 = Time.now
    t2 = t1 - 240 # a few minutes earlier
    show_uptime(t2).should == "Uptime is 0 hours and 4 minutes"
  end
  
  it "should handle a reasonable time (hours)" do
    t1 = Time.now
    t2 = t1 - (6*60*60 + 52*60) # somewhere in a work day
    show_uptime(t2).should == "Uptime is 6 hours and 52 minutes"
  end
  
  it "should handle a single day" do
    t1 = Time.now
    t2 = t1 - (24*60*60 + 6*60*60 + 52*60) # some days ago
    show_uptime(t2).should == "Uptime is 1 day, 6 hours and 52 minutes"
  end
  
  it "should handle a long time (days)" do
    t1 = Time.now
    t2 = t1 - (2*24*60*60 + 6*60*60 + 52*60) # some days ago
    show_uptime(t2).should == "Uptime is 2 days, 6 hours and 52 minutes"
  end
  
  
end
  

 
# # Original, as Posted by Matthias Reitinger
# 
# require 'time'
# 
# methods = [
#   lambda { # Windows
#     require 'Win32API'
#     getTickCount = Win32API.new("kernel32", "GetTickCount", nil, 'L')
#     Time.now - getTickCount.call() / 1000.0
#   },
#   lambda { # *BSD, including Mac OS
#     Time.at(`sysctl -b kern.boottime 2>/dev/null`.unpack('L').first)
#   },
#   lambda { # Some other form of *nix
#     Time.parse(`who -b 2>/dev/null`)
#   }
# ]
# 
# begin
#   unless methods.empty?
#     boot_time = methods.shift.call
#   else
#     puts "Unable to determine time of last reboot.  Sorry!"
#     exit!(1)
#   end
# rescue Exception
#   retry
# end
# 
# puts "Last reboot: #{boot_time.asctime}"
# 

