class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :customers, dependent:destroy
  has_many :items, dependent:destroy
end
