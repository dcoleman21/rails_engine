require 'rails_helper'

describe Transaction do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoices }
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :credit_card_expiration_date }
    it { should validate_presence_of :result }

  end
end
