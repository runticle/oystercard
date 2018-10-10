require 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :journeys
  DEFAULT_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @entry_station
    @journeys = []
  end

  def top_up(amount)
    raise "Limit of £#{@limit} exceeded" if (@balance + amount) > @limit
    @balance += amount
  end

  def touch_in(station)
    raise "not enough money" if @balance < MINIMUM_CHARGE
    @journey = Journey.new
    @journey.start(station)
    @entry_station = station
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(@journey.fare)
    add_to_journeys(station)
  end

  def in_journey?
    true if @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_to_journeys(station)
    @complete_journey = { @entry_station => station }
    @journeys << @complete_journey
    @entry_station = nil
  end
end
