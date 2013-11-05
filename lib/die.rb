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

