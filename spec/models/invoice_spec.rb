require 'rails_helper'

describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer}
    it { should have_many :items }
    it { should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
  end
end
