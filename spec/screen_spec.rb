require_relative '../screen'

RSpec.describe Screen do
  let(:cls) { described_class.new }

  it 'Test screen message' do
    expect do
      cls.display_line_message('Hola')
    end.to output('Hola').to_stdout
  end
end
