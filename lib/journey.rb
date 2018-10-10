class Journey

  attr_reader :entry_station

MIN_FARE = 1
PENALTY = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

def start(station)
  @entry_station = station
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

def complete?
  true if @entry_station != nil && @exit_station != nil
end

end
