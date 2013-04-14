#First things first, most of the comments are to myself as I am pondering the functionality, as I progress I'll remove them or refine them to be more consise, until then they might seem ramblish.

#Also of note, this is definitely going to need a good reworking of variable names as I've just started shoving certain things here and there as I try and get this to do what I want

require 'yaml'

class Die

  def initialize
    roll
  end

  def roll
    @num_rolled = rand(100)
  end

  def result
    @num_rolled
  end

end


class Hero
#level needs to be removed and adjusted for in the attacking etc. just need to use x.length

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


class Weapon < Hero

  def initialize (aType)
    super @name
    @type = aType
  end

end

def lineup( anArray )
  @count = 1
  anArray.each do |x| 
    puts @count.to_s + ')' + x.show_name
    @count += 1
  end
  puts ''
end


def revive( liveArray, deadArray )
  lineup( deadArray )
  puts 'Which hero do you wish to pull from the cold clutches of Death?'
  input = gets.chomp.to_i - 1
  liveArray.push(deadArray[input])
  deadArray.delete_at(input)
end


#save currently just overwrites the existing files, needs refinement
def yaml_save object, filename
  File.open filename, 'w' do |f|
    f.write(object.to_yaml)
  end
end


#loading also kills any heroes in the current running game, make it append?
def yaml_load filename
  yaml_string = File.read filename

  YAML::load yaml_string
end



class Combat
  # This needs some rework its gotten fat and clumsy, but it works...
  # I should include a transcript of the combat to be saved to a text file just for fun

  def initialize( anArray, fallen, boolSpar )
     combat( anArray, fallen, boolSpar )
  end

  def combat( anArray, fallen, boolSpar )
    @spar = boolSpar
    @range = anArray.length
    if @range <= 1
      puts 'There are not enough available combatants'
    else
      puts '<<The Heroes>>'
      lineup(anArray)
      puts ''
      valid_choice = false
#need a catch in here for outside index numbers...
      while (not valid_choice)
        puts 'First combatant\'s number? #NEEDS A CATCH FOR NON INTEGERS HERE'
        c1 = gets.chomp.to_i - 1
        puts 'Second combatant\'s number?'
        c2 = gets.chomp.to_i - 1
        if c2 == c1
    puts anArray[c1].show_name + ' cannot fight themselves! Choose again.'
	else
	  valid_choice = true
	end
      end

      #need to think of a better health system, but I want multiple hits to win for now...      
      @c1health = anArray[c1].get_level + 1
      @c2health = anArray[c2].get_level + 1

      puts 'Let the battle begin!'
      puts ''
      victory = false
      while (not victory)
	@c1a = attack( anArray[c1] )
	@c2a = attack( anArray[c2] )
	print '(' + @c1a.to_s + 'x' + @c2a.to_s + ')'

        #need to read more on comparable module, might make a lot more sense to use it here
	#should I define the % ranges as verious levels of hits and/or misses i.e. 0-25 misses etc, 		perhaps even defining criticals as compared, if high enough blocking/parrying happens...

	if @c1a == @c2a
	  puts 'It\'s that moment in a fight when they bring their weapons together and glare at one another face to face'
	elsif @c1a > @c2a
	  @c2health -= 1
	  puts anArray[c1].first_name + ' wounds ' + anArray[c2].first_name
	  if @c2health < 0
            puts ''
	    puts anArray[c1].show_name + ' strikes down ' + anArray[c2].show_name
	    if @spar == false
	      puts 'Give \'' + anArray[c1].show_name + '\' an addtion to his name'
	      input = gets.chomp
	      anArray[c1].add_name(input)
	      fallen.push(anArray[c2])
	      anArray.delete_at(c2)
	    end
	    victory = true
	  end
	elsif @c1a < @c2a
	  @c1health -= 1
	  puts anArray[c2].first_name + ' wounds ' + anArray[c1].first_name
	  if @c1health < 0
            puts ''
	    puts anArray[c2].show_name + ' strikes down ' + anArray[c1].show_name
	    if @spar == false
	      puts 'Give \'' + anArray[c2].show_name + '\' an addtion to his name'
	      input = gets.chomp
	      anArray[c2].add_name(input)
	      fallen.push(anArray[c1])
	      anArray.delete_at(c1)
	    end
	    victory = true
	  end
	end
      end
    end
  end

  def attack( aHero )
    @hero = aHero
    @result = Die.new.roll + (@hero.get_level * 2)
    return @result
  end

  #kill(or retire method, can double duty it...) method maybe to clean up the combat section a bit...

end


input = ''
heroes = []
fallen = []


while input != 'exit'
  print '>'
  input = gets.chomp.downcase

  if input == 'help'
    puts 'exit, list, new, fallen, load, save, revive'
  elsif input == 'list'
    puts ''
    puts '<<The Heroes>>'
    lineup(heroes)
  elsif input == 'fallen'
    puts '<<The Fallen>>'
    lineup(fallen)
  elsif input == 'new'
    puts 'Hero\'s name?'
    @name = gets.chomp
    heroes.push(Hero.new( @name ))
    puts 'Hero ' + @name + ' has been created.'
  elsif input == 'revive'
    revive( heroes, fallen )
  elsif input == 'fight'
    Combat.new(heroes, fallen, false)
  elsif input == 'spar'
    Combat.new(heroes, fallen, true)
  elsif input == 'save'
#need to put a catch in save, easy to save over the files at the moment
    filename = 'Heroes.txt'
    yaml_save heroes, filename
    filename = 'Fallen.txt'
    yaml_save fallen, filename
  elsif input == 'load'
    filename = 'Heroes.txt'
    heroes = yaml_load filename
    filename = 'Fallen.txt'
    fallen = yaml_load filename
  end
end
