require 'rails_helper'

describe CarModelPresenter do
  describe '#car_options' do
    it 'should render as an unordered list' do
      car_model = build(:car_model, car_options: 'ar cand, teto solar, car play')

      result = CarModelPresenter.new(car_model.decorate).car_options

      expect(result).to eq('<ul><li>ar cand</li><li>teto solar</li><li>car play</li></ul>')
    end
  end
end