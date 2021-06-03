require_relative '../account'
require_relative '../bank_data_base'

RSpec.describe Account do
  let(:cls) { described_class.new }

  it 'test pin' do
    BankDataBase.new.authenticate_user('20213569', '14926')
    expect(cls.validate_pin).to be_truthy
  end

  it 'Test data base interaction' do
    BankDataBase.new.authenticate_user('20213569', '14926')
    expect(cls.available_balance).to eq 2725
  end
end
