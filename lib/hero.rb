class Hero
#level needs to be removed and adjusted for in the attacking etc. just need to use x.length

#Structure of Hero should change, I think the nested arrays are causing a lot of my headaches. I think I should just break the name down into a string and figure out how to deliminate via spaces and whatnot.

  def initialize( aName )
    @name = []
    @name.push( aName )
    @level = @name.length
  end

  def add_name
    puts 'Give ' +  + 'an additional name.'
    input = gets.chomp +
    @name.push( input )
    @level = @name.length
  end

  def add_name( aName )
    @name.push( aName )
    @level = @name.length
  end

  def show_name
    @name.join(" ")
  end

  def first_name
    @name.first
  end

  def get_level
    return @level
  end

end
