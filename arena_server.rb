require 'drb'

class ArenaServer
  def initialize
    @pen = []
    @name = ''
  end
  def cage(name)
    @pen.push(name)
    if @pen.size <= 1
      puts 'waiting for another fighter.'
    else
      puts @pen.pop + ' fights ' + @pen.pop
    end
  end
end
server = ArenaServer.new
DRb.start_service('druby://localhost:9000', server)
DRb.thread.join
