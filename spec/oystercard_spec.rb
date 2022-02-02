require_relative '../lib/oystercard.rb' 

describe Oystercard do
  let(:entry_station){double(:entry_station, :name => "Oxford")}
  let(:exit_station){double(:exit_station, :name => "Holborn")}
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'should have an opening balance of 0' do
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if the maximum balance is reached' do 
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      expect { subject.top_up 1 }.to raise_error "You have reached the maximum possible balance of #{maximum_balance}"
    end 
  end

  describe '#in_journey?' do 
    it 'is initially not in journey' do 
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'can touch in' do 
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey 
    end

    it 'Will not touch_in if it is below the minimum balance' do
      expect { subject.touch_in(entry_station) }.to raise_error "Insufficient funds to touch in, Please top up"
    end

    it 'Store Entry Station' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.entry_station.name).to eq entry_station.name

    end
  end

  describe '#touch_out' do
    it 'can touch out' do
      card = Oystercard.new
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it 'Should Clear the entry Station' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to be_nil
    end
    
    it 'store an exit station' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    it "there are no journeys" do
      expect(subject.journeys).to be_empty
    end

    it 'stores a journey' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey 
    end

  
  end
end


