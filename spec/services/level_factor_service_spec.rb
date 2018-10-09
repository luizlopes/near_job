require 'rails_helper'

describe LevelFactorService do
  it 'calculate the factor for 1 and 5' do
    factor = LevelFactorService.call(1, 5)

    expect(factor).to eq(0)
  end

  it 'calculate the factor for 3 and 5' do
    factor = LevelFactorService.call(3, 5)

    expect(factor).to eq(50)
  end

  it 'calculate the factor for 5 and 5' do
    factor = LevelFactorService.call(5, 5)

    expect(factor).to eq(100)
  end
end
