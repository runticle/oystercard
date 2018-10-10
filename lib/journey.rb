class Journey

  attr_accessor :entry_station, :exit_station, :journey

MIN_FARE = 1
PENALTY = 6

  def initialize(station = 'station')
    @entry_station = station
    @exit_station
  end

  def finish(station)
    @exit_station = station
  end

  def fare
    if complete?
      MIN_FARE
    else
      PENALTY
    end
  end

  def journey
    @journey = { entry: @entry_station,
                 exit: @exit_station
                }
  end

  def complete?
    true if @entry_station != nil && @exit_station != nil
  end

end
