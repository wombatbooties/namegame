#!/usr/bin/env ruby
require 'drb'
require 'highline/import'
require 'colored'

DRb.start_service()

# arena.heroes # return an array of heroes in the pen 
#              # provide empty array if no heroes there yet
#
# arena.count  # returns fight count 

def get_name
  ask("give me a name to submit to local arena") { |q|
    q.validate = /\w+/
  }
end

arena = DRbObject.new(nil, 'druby://localhost:9000')
begin
  heroes = arena.heroes
  puts "Connected to areana"
  if heroes.size > 0
    puts heroes.collect { |h| h[:name] }.inspect
  else
    puts "arena is currently empty".yellow
  end
rescue Exception => error
  puts "Exception: #{error}"
end

hero = ARGV.shift || get_name()

case hero
when 'list'
  heroes = arena.heroes
  puts heroes.collect { |h| h[:name] }.inspect
  exit 
else 
  puts "submitting #{hero}"
  arena.cage(hero)
end

not_done = true
count = arena.count
while(not_done) 
  next if count == arena.count 
  count = arena.count
  heroes = arena.heroes
  me = false
  heroes.each { |h| me = h if h[:name] == hero }
  if me
    puts "#{hero} is still alive! Kills: #{me[:kills].collect{ |k| k[:name]}.join(", ")}".green
  else
    puts "#{hero} died..".red
    exit 
  end
  sleep 3
end
