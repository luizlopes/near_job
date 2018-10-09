require 'rails_helper'

describe ScoreService do
  it 'returns the sum of level factor of 75 with distance factor of 25'\
     ' and div by 2' do
    a_job = build(:job)
    a_person = build(:person)

    level_factor = double(:level_factor, call: 75)
    distance_factor = double(:distance_factor, call: 25)

    score = ScoreService.new(level_factor, distance_factor)
                        .call(a_job, a_person)

    expect(score).to eq(50)
  end

  it 'returns the sum of level factor of 100 with distance factor of 50'\
     ' and div by 2' do
    a_job = build(:job)
    a_person = build(:person)

    level_factor = double(:level_factor, call: 100)
    distance_factor = double(:distance_factor, call: 50)

    score = ScoreService.new(level_factor, distance_factor)
                        .call(a_job, a_person)

    expect(score).to eq(75)
  end
end
