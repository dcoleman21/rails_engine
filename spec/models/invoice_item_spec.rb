require 'rails_helper'

describe InvoiceItem do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end
end
