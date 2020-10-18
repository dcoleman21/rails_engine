class Transaction < ApplicationRecord
  validates :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, presence: true

  belongs_to :merchant
  has_many :invoices
  has_many :invoices, through: :invoice_items
end
