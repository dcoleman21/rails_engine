class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  # has_many :invoices, dependent:destroy
  # has_many :invoice_items, through: :invoices
  # has_many :items, through: :invoice_items
end
