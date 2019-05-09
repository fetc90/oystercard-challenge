
class Oystercard
  MAXIMUM_AMOUNT = 90
  MINIMUM_AMOUNT = 1
  FARE = 1
  attr_reader :balance, :journey, :entry_station, :journies

  def initialize(balance= 0, journey = false)

    @balance = balance
    @journey = journey
    @journies = []
    @entry_station = entry_station

  end

  def top_up(n)
    raise "top up (#{MAXIMUM_AMOUNT}) limit reached" if @balance + n > MAXIMUM_AMOUNT
    @balance += n
  end

private
  def deduct(n)
    @balance -= n
  end
public

  def in_journey?
    @journey
  end

  def touch_in(entry_station)
    raise "insufficient travel funds" if @balance < MINIMUM_AMOUNT
    @journey = true
    @journies << entry_station

  end

  def touch_out
    @balance -= FARE
    @journey = false
  end

end
