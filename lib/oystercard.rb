
class Oystercard
  MAXIMUM_AMOUNT = 90
  MINIMUM_AMOUNT = 1
  FARE = 1
  attr_reader :balance, :entry_station, :journey_log, :exit_station, :one_journey

  def initialize(balance= 0)

    @balance = balance
    @entry_station = nil
    @journey_log = []
    @one_journey = Hash.new

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

  def touch_in(entry_station)
    raise "insufficient travel funds" if @balance < MINIMUM_AMOUNT
    @entry_station = entry_station
  end

  def in_journey?
   @entry_station != nil
  end

  def touch_out(exit_station)
    @balance -= FARE
    @exit_station = exit_station
    @one_journey = {"entry_station": entry_station, "exit_station": exit_station }
  end

  def log
    @journey_log << @one_journey
  end

end
