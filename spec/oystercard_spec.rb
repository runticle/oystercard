require 'oystercard'

describe Oystercard do
  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe "#top up" do
    it "tops up the card by 10" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it "raises an error if limit is exceeded" do
      max_balance = Oystercard::DEFAULT_LIMIT
      expect{subject.top_up(max_balance + 1)}.to raise_error "Limit of £#{max_balance} exceeded"
    end
  end

  describe "journey methods" do
    let(:entry_station) {double (:station)}
    let(:exit_station) {double (:station)}

    it "is initially not in journey" do
      expect(subject).not_to be_in_journey
    end
    it "changes in_journey to true when we touch_in" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
    it "touches in and out and in_journey is false" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    it "raises an error if balance is less than fare" do
      subject.top_up(0.5)
      expect {subject.touch_in(entry_station)}.to raise_error "not enough money"
    end
    it "deducts the fare when you touch out" do
      subject.top_up(5)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end
    it "remembers the entry station after touch in" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
    it "resets entry station to nil when touching out" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end
    it "checks a new card has no journeys" do
      expect(subject.journeys).to be_empty
    end
    it "checks that touching in and out creates one journey" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys.length).to eq 1
    end
  end
end
