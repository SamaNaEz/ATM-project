require_relative './screen'
require_relative './bank_data_base'
require_relative './deposit_slot'

class Deposit

  def initialize
    @message = Screen.new
  end

  def execute(amount, account_number)
    record = BankDataBase.new.records.find do |r|
      if r[:account].to_i == account_number
        r
      else
        nil
      end
    end
    if amount.to_i != 0
      @message.display_line_message("\n Please put envelope in deposit slot")
      deposit_status = DepositSlot.new.is_envelope_received
      if deposit_status == true
        record[:total_balance] = record[:total_balance].to_i + amount / 100
        BankDataBase.new.transaction
        @message.display_line_message("\n==================================")
        @message.display_line_message("\nYour deposit was approved!\n")
        @message.display_line_message("\nThanks!")
        @message.display_line_message("\n==================================\n")
      else
        @message.display_line_message("\nTime out")
        @message.display_line_message("\nOperation canceled by the system")
        exit
      end
    else
      @message.display_line_message("\nOperation canceled")
      @message.display_line_message("\nThanks for use us services!")
      exit
    end
  end
end
