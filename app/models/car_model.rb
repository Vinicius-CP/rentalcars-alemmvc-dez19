class CarModel < ApplicationRecord
  belongs_to :manufacture
  belongs_to :fuel_type
  belongs_to :category
  has_many :cars
  validates :name, presence: true
  validates :year, presence: true
  validates :car_options, presence: true
end
