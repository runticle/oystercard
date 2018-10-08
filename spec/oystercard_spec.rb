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
end
