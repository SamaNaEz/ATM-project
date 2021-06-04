require 'csv'

class BankDataBase
  attr_reader :records

  def initialize
    @records = CSV.foreach('./data_base.csv', headers: true, header_converters: :symbol).map { |row| row }
  end

  def transaction(acc, curr_amt, tot_bal)
    heads = ['account', 'secret', 'name', 'last_name', 'current_amount', 'total_balance']
    CSV.open('./data_base.csv', 'w', headers: heads, write_headers: true) do |csv|
      records.each do |record|
        if record[:account] == acc
        csv << [record[:account], record[:secret], record[:name], record[:last_name], curr_amt, tot_bal]
        else
        csv << [record[:account], record[:secret], record[:name], record[:last_name], record[:current_amount], record[:total_balance]]
        end
      end
    end
  end
end
