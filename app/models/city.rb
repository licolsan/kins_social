class City < ApplicationRecord
  has_many :users
  belongs_to :country

  validates :name, uniqueness: true
  validates :name, presence: true
end
