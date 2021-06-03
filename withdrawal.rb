require_relative './screen'
require_relative './bank_data_base'
require_relative './cash_dispenser'

class Withdrawal

  def initialize
    @message = Screen.new
  end

  def execute(amount, account_number)
    withdraw_amount = menu(amount)
    record = BankDataBase.new.records.find do |r|
      if r[:account].to_i == account_number
        r
      else
        nil
      end
    end

    if record[:current_amount].to_i > withdraw_amount
      if CashDispenser.new.is_sufficient_cash_available(withdraw_amount)
        record[:current_amount] = record[:current_amount].to_i - withdraw_amount
        record[:total_balance] = record[:total_balance].to_i - withdraw_amount
        BankDataBase.new.transaction
        CashDispenser.new.dispense_cash
        # ATM.new.withdraw_status = true
      else
        @message.display_line_message("\nSorry!")
        @message.display_line_message("\nIn this moment We do not have sufficient cash, try with a smaller amount!")
      end
    else
      @message.display_line_message("\nYou do not have sufficient cash for withdraw, try with a smaller amount!")
    end
  end

  def menu(amount)
    case amount
    when 1 then amount = 20
    when 2 then amount = 40
    when 3 then amount = 60
    when 4 then amount = 100
    when 5 then amount = 200
    when 6 then exit
    else
      @message.display_line_message("\nThe option that you was selected is not exist, try again!!")
    end
  end
end
