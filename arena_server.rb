require 'drb'

class ArenaServer
  def initialize
    @pen = []
    @name = ''
    @count = 0
  end

  def count
    return @count
  end

  def heroes
    return @pen
  end

  def cage(name)
    @pen.push(name)
    if @pen.size <= 1
      puts 'waiting for another fighter.'
    else
      @count += 1
      @heroA = @pen.pop
      @heroB = @pen.pop
      if rand(100) >= 50
        @pen.push(@heroA)
      else
	@pen.push(@heroB)
      end
    end
  end
end

server = ArenaServer.new
DRb.start_service('druby://localhost:9000', server)
DRb.thread.join
