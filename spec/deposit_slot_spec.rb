require_relative '../deposit_slot'

RSpec.describe DepositSlot do
  let(:cls) { described_class.new }

  it 'Test status of deposit slot' do
    expect(cls.is_envelope_received).to be_truthy
  end
end
