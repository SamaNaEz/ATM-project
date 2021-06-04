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
      @message.display_line_message("\nPlease put envelope in deposit slot\n")
      deposit_status = DepositSlot.new.is_envelope_received
      if deposit_status == true
        record[:total_balance] = record[:total_balance].to_f + amount / 100
        BankDataBase.new.transaction(record[:account], record[:current_amount], record[:total_balance])
        @message.display_text_highlighted_sup('Your deposit was approved!')
        @message.display_text_highlighted_inf('Thanks!')
      else
        @message.display_text_highlighted_sup('Time out')
        @message.display_text_highlighted_inf('Operation canceled by the system')
        false
      end
    else
      @message.display_text_highlighted_sup('Operation canceled')
      @message.display_text_highlighted_inf('Thanks for use us services!')
    end
  end
end
