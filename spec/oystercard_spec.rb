require 'oystercard'

describe Oystercard do
subject(:card) {described_class.new}

  it "has a balance" do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it "allows customer to top up" do
      expect(subject).to respond_to(:top_up).with(1).argument
  end

    it "raise an error when limit reached" do
      subject.top_up(90)
      expect{ subject.top_up(1) }.to raise_error("top up (#{Oystercard::MAXIMUM_AMOUNT}) limit reached")
    end
  end

  describe "#touch_in" do

    it "raises an error if card balance too low" do
    expect { card.touch_in(:entry_station) }.to raise_error("insufficient travel funds")
    end

      it "starts journey" do
      card = Oystercard.new(10)
      card.touch_in(:entry_station)
      expect(card.in_journey?).to eq(true)
      end
    end

      describe 'entry station double' do
        let (:entry_station) { double :entry_station}
        it "remembers the station after touch_in" do
          card = Oystercard.new(10)
          expect(card.touch_in(:entry_station)).to eq(:entry_station)
        end
      end



    describe "#touch_out" do
      it "ends journey" do
        subject.touch_out(:exit_station)
        expect(subject).not_to be_in_journey
      end

    #   it "forgets the entry_station" do
    #     card = Oystercard.new(10)
    #     card.touch_in(:entry_station)
    #     card.touch_out(:exit_station)
    #     expect(card.touch_out(:exit_station)).to eq(exit_station)
    #   end
    # end

      it "charges card on touch out" do
      expect {subject.touch_out(:exit_station)}.to change{subject.balance}.by(-Oystercard::FARE)
      end

      it "stores one journey log" do
        card = Oystercard.new(10)
        card.touch_in(:entry_station)
        card.touch_out(:exit_station)

        expect(card.one_journey).to include(:entry_station, :exit_station)
      end

    end

      describe 'exit station double' do
        let(:exit_station) { double :exit_station }
        it "remembers the exit station" do
          expect(card.touch_out(exit_station)).to eq(card.one_journey)
        end
      end

      it 'checks that the journey log is empty' do
        expect(card.log).to eq [{}]
      end


  end
