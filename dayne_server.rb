#!/usr/bin/env ruby
require 'drb'

class ArenaServer
  def initialize
    @pen = []
    @name = ''
    @count = 0
  end

  def cage(name)
    name = name.to_s
    puts "hero submitted to cage : #{name.inspect}"
    return "invalid name submitted" unless name and name.size > 2
    @pen.push(name)
  end

  def count()
    @count
  end

  def heroes()
    return @pen
  end

  def fight()
    if @pen.size <= 1
      puts 'waiting for another fighter.'
    else
      first = @pen.delete_at(rand(@pen.size))
      second = @pen.delete_at(rand(@pen.size))
      puts first + ' fights ' + second
      winner = (rand(10)>5)?(first):(second)
      puts "the winner is #{winner}"
      @count += 1
      @pen.push(winner)
    end
    puts "current @pen: #{@pen.inspect}"
  end

  def spin()
    loop do
      fight if @pen.size > 1
      sleep 2  
      puts @pen.inspect if rand(10) == 1
    end
  end
end
server = ArenaServer.new
DRb.start_service('druby://localhost:9000', server)

server.spin

DRb.thread.join
