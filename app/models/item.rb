class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true

  has_many :customers, dependent: :destroy
  has_many :merchants, dependent: :destroy
  belongs_to :merchant
end
