class Country < ApplicationRecord
  has_many :users
  has_many :cities

  validates :name, uniqueness: true
  validates :name, presence: true
end
