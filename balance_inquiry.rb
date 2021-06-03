require_relative './screen'
require_relative './bank_data_base'

class BalanceInquiry

  def initialize
    @message = Screen.new
  end

  def execute(account_number)
    r = BankDataBase.new.records.find { |record| record[:account].to_i == account_number }
    @message.display_line_message("\n==================================")
    @message.display_line_message("\nHi, #{r[:name]} #{r[:last_name]}")
    @message.display_line_message("\nYour total balance is: #{r[:total_balance]}")
    @message.display_line_message("\nYour available amount is: #{r[:current_amount]}")
    @message.display_line_message("\n==================================\n")
  end
end
