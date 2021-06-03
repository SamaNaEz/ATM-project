require_relative '../bank_data_base'
require_relative '../account'

RSpec.describe BankDataBase do
  let(:cls) { described_class.new }

  it 'Test false user' do
    expect(cls.authenticate_user('2356154', '15926')).to be_falsey
  end

  it 'Test true user' do
    expect(cls.authenticate_user('20213569', '14926')).to be_truthy
  end

  it 'Test available balance' do
    cls.authenticate_user('20213569', '14926')
    expect(cls.available_balance).to eq 2725
  end

  it 'Test total balance' do
    cls.authenticate_user('20213569', '14926')
    expect(cls.total_balance).to eq 2725
  end
end
