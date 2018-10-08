class Oystercard
  attr_reader :balance, :entry_station
  DEFAULT_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @entry_station
  end

  def top_up(amount)
    raise "Limit of £#{@limit} exceeded" if (@balance + amount) > @limit
    @balance += amount
  end

  def touch_in(station)
    raise "not enough money" if @balance < MINIMUM_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    true if @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
