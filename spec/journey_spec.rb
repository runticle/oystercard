require 'journey'




describe Journey do

let (:station) {double (:station)}
let (:min_fare) {Journey::MIN_FARE}
let (:penalty) {Journey::PENALTY}


  it 'starts a journey' do
    expect(subject.start(station)).to eq station
  end

  it 'finishes a journey' do
    expect(subject.finish(station)).to eq station
  end

  it 'has a penalty by default' do
    expect(subject.fare).to eq(penalty)
  end

  it 'calculates fare' do
    subject.start(station)
    subject.finish(station)
    expect(subject.fare).to eq(min_fare)
  end

  it 'knows when a journey is complete' do
    subject.start(station)
    subject.finish(station)
    expect(subject).to be_complete
  end

  it 'knows when a journey is not complete' do
    subject.start(station)
    expect(subject).not_to be_complete
  end

  it 'charges penalty if journey is not complete' do
    subject.finish(station)
    expect(subject.fare).to eq(penalty)
  end

end
