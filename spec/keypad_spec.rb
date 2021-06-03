require_relative '../keypad'

RSpec.describe Keypad do
  let(:cls) { described_class.new }

  it 'Test keypad' do
    allow($stdin).to receive(:gets).and_return('Hola')

    expect($stdin.gets).to eq 'Hola'
  end
end
