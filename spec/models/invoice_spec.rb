require 'rails_helper'

describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer}
    it { should belong_to :merchant}
    it { should have_many :transactions}
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end
end
