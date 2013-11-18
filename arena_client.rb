require 'drb'
require 'highline/import'
require 'colored'

DRb.start_service()

# arena.heroes # return an array of heroes in the pen 
#              # provide empty array if no heroes there yet
#
# arena.count  # returns fight count 

begin
  arena = DRbObject.new(nil, 'druby://localhost:9000')
  heroes = arena.heroes
  puts "Connected to areana"
  if heroes.size > 0
    hereos.each_with_index do |h,i|
      puts "#{i} : #{h.inspect.green}"
    end
  else
    puts "arena is currently empty".yellow
  end
rescue Exception => error
  puts "Exception: #{error}"
end

def get_name
  ask("give me a name to submit to local arena") { |q|
    q.validate = /\w+/
  }
end

hero = ARGV.shift || get_name()
puts "submitting #{hero}"
arena.cage(hero)

not_done = true
count = arena.count
while(not_done) 
  next if count == arena.count 
  count = arena.count
  heroes = arena.heroes
  if heroes.include?(hero)
    puts "you are still alive!"
  else
    puts "you died.."
    exit 
  end
  sleep 3
end
