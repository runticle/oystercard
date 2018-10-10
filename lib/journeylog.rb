class JourneyLog

  attr_reader :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    # @journey
    @journeys = []
  end

  def start(station)
    binding.pry
    @journey = @journey_class.new(station)
    @journeys << @journey
  end

  def finish(station)
    if @journey == nil
      @journey = @journey_class.new(station)
      @journeys << @journey
    end
    @journeys.last.exit_station = station
    @journey = nil
  end

  private
  def current_journey
    @journey ||= journey_class.new
  end

end
