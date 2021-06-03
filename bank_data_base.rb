require 'csv'

class BankDataBase
  attr_reader :records

  def initialize
    @records = CSV.foreach('./data_base.csv', headers: true, header_converters: :symbol).map { |row| row }
  end

  def transaction
    head = ['account', 'secret', 'name', 'last_name', 'current_amount', 'total_balance']
    CSV.open('./data_base.csv', 'w', headers: head, write_headers: true) do |csv|
      #records[0] = ['account', 'secret', 'name', 'last_name', 'current_amount', 'total_balance']
      records.each do |record|
        csv << [record[:account], record[:secret], record[:name], record[:last_name], record[:current_amount], record[:total_balance]]
      end
    end
  end
end
