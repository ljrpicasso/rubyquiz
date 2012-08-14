class Hamurabi 

  def initialize 
    @people = 100
    @total_acres = 1000
    @farm_acres = 0
    @total_bushels = 0
    @r = Random.new(5000)
    @bushels_per_acre = @r.rand(17..26)
    @year = 0
  end

  def people_arrive
    @new_people = @r.rand(0...7)
    @people = @people + @new_people
  end

  def plant_the_fields 
    puts "How many acres to plant this year? "
    @new_acres = @r.rand(1...@total_acres)

    # we can only plant 10 acres per person
    # and we need a bushel per acre to plant.
    return false if (@farm_acres+@new_acres)/10 > @people
    return false if (@farm_acres+@new_acres) > @total_bushels
    true
  end

  def a_year_passes 
    people_arrive
    plant_the_fields
    #work_the_land
    #people_die
    #harvest_is_gathered
    #pests_are_pesty
    #feed_the_people
    #buy_or_sell_land
    #land_price_fluctuates
    @year = @year + 1
    report_progress
  end

  def report_progress 
    puts "Year #{@year}:"
    puts "... #{@people} people are depending on you"
    puts "... You own #{@total_acres} acres, with #{@farm_acres} used for farming"
    puts "... You have #{@total_bushels}bushels in storage -- value is #{@bushels_per_acre} bushels per acre"
  end


end


h = Hamurabi.new
h.a_year_passes

