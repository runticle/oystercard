class Oystercard
  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
  end

  def top_up(amount)
    raise "Limit of £#{@limit} exceeded" if (@balance + amount) > @limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end 
end
