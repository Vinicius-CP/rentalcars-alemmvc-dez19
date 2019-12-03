require 'rails_helper'

describe CarModelPresenter do 
  describe '#car_options' do 
    it 'shoul do car options' do
      car_model = build(:carl_model)

      result = CarModelPresenter.new(car_model).car_options

      expect(result).to eq('<ul><li>ar cand</li><li>teto solar</li></ul>')
    end
  end
end