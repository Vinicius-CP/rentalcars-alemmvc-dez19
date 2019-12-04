require 'rails_helper'

describe RentalActionsAuthorizer do
  describe '.authorized?' do
    it 'should authorize admins' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, role: :admin, subsidiary: subsidiary)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan', category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
          subsidiary: subsidiary)
      rental = create(:rental, status: :scheduled, category: category, subsidiary: subsidiary,
        start_date: 1.day.from_now, end_date: 10.days.from_now)

      expect(described_class.new(rental, user)).to be_authorized #espera que seja true, authorized?
    end

    it 'should authorize same subsidiary users' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, subsidiary: subsidiary)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan', category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
          subsidiary: subsidiary)
      rental = create(:rental, status: :scheduled, category: category, subsidiary: subsidiary,
        start_date: 1.day.from_now, end_date: 10.days.from_now)

      expect(described_class.new(rental, user)).to be_authorized #espera que seja true, authorized?
    end

    it 'should not authorize different subsidiary users' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      other_subsidiary = create(:subsidiary, name: 'Vini Motors')
      user = create(:user, subsidiary: other_subsidiary)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
      third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan', category: category)
      create(:car, car_model: car_model, license_plate: 'TAT-1234',
          subsidiary: subsidiary)
      rental = create(:rental, status: :scheduled, category: category, subsidiary: subsidiary,
        start_date: 1.day.from_now, end_date: 10.days.from_now)

      expect(described_class.new(rental, user)).not_to be_authorized #espera que seja true, authorized?
    end
  end
end