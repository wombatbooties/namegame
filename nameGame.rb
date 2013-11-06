#!/bin/env ruby

class NameGame

#First things first, most of the comments are to myself as I am pondering the functionality, as I progress I'll remove them or refine them to be more consise, until then they might seem ramblish.

#Also of note, this is definitely going to need a good reworking of variable names as I've just started shoving certain things here and there as I try and get this to do what I want

require 'yaml'

require './lib/die.rb'
require './lib/hero.rb'
require './lib/weapon.rb'
require './lib/combat.rb'

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

puts 'Holy Broken Program Batman!'

@quitBool = false
input = ''
heroes = []
fallen = []

while @quitBool == false
  print '>'
  input = gets.chomp.downcase

  if input == 'help'
    puts 'exit, list, new, fallen, load, save, revive'
  elsif input == 'exit'
    quitBool = true
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

end
