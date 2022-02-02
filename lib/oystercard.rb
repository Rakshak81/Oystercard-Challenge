class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail 'You have reached the maximum possible balance of 90' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
   !!entry_station
  end

  def touch_in(station)
    fail 'Insufficient funds to touch in, Please top up' if balance < MINIMUM_FARE
    @exit_station = nil
    @entry_station = station
  end 

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @journeys << {entry_station: @entry_station, exit_station: station}
    @entry_station = nil
  end
 
  private
  
  def deduct(amount)
    @balance -= amount
  end

end
