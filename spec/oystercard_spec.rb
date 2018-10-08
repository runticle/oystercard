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

  describe "#deduct" do
    it "deducts 2 from the balance" do
      subject.deduct(2)
      expect(subject.balance).to eq -2
    end
  end

  describe "journey methods" do
    it "is initially not in journey" do
      expect(subject).not_to be_in_journey
    end
    it "changes in_journey to true when we touch_in" do
      subject.top_up(5)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "touches in and out and in_journey is false" do
      subject.top_up(5)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
    it "raises an error if balance is less than fare" do
      subject.top_up(0.5)
      expect {subject.touch_in}.to raise_error "not enough money"
    end
  end
end
