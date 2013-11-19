#!/usr/bin/env ruby
require 'drb'

class ArenaServer
  def initialize
    @pen = []
    @id = 0
    @count = 0
  end

  def count
    @count
  end

  def heroes
    @pen
  end

  def get_id
    @id += 1
  end

  def combat(white, black)
    wscore = white[:kills].size() + rand(5)
    bscore = black[:kills].size() + rand(5)
    if wscore >= bscore
      return white, black
    else
      return black, white
    end
  end

  def cage(name)
    @pen.push({:id => get_id(),
               :name => name,
               :kills => [] }  )
    @pen.last()
  end

  def fight
    if @pen.size <= 1
      puts 'waiting for another fighter.'
    else
      @count += 1
      heroA = @pen.delete_at(rand(@pen.size))
      heroB = @pen.delete_at(rand(@pen.size))
      winner, loser = combat(heroA, heroB)
      winner[:kills].push(loser)
      @pen.push(winner)
      puts winner[:name] + " was victorious over " + loser[:name] + "!"
    end
  end
end

server = ArenaServer.new
DRb.start_service('druby://localhost:9000', server)
loop do
  server.fight()
  sleep 4
end
DRb.thread.join
