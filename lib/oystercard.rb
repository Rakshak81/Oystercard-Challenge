class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_accessor :in_journey 

  def initialize
    @balance = 0
    @in_journey = false 
  end

  def top_up(amount)
    fail 'You have reached the maximum possible balance of 90' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end 

  def touch_in
    fail 'Insufficient funds to touch in, Please top up' if balance < MINIMUM_FARE
    @in_journey = true 
  end 

  def touch_out 
    @in_journey = false 
  end 

end
