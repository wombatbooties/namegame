require 'drb'

DRb.start_service()
manager = DRbObject.new(nil, 'druby://localhost:9000')

name1 = ARGV.shift 
name2 = ARGV.shift 
puts "submitting #{name1} and #{name2}"
manager.cage(name1)
manager.cage(name2)
