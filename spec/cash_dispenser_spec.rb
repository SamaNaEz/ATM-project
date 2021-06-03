require_relative '../cash_dispenser'

RSpec.describe CashDispenser do
  let(:cls) { described_class.new }

  it 'Test sufficient amount' do
    expect(cls.is_sufficient_cash_available(455)).to be_truthy
  end
end
