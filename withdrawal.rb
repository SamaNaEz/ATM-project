require_relative './screen'
require_relative './bank_data_base'
require_relative './cash_dispenser'

class Withdrawal

  def initialize
    @message = Screen.new
  end

  def execute(amount, account_number, cash_atm)
    withdraw_amount = menu(amount)
    record = BankDataBase.new.records.find do |r|
      if r[:account].to_i == account_number
        r
      else
        nil
      end
    end

    if withdraw_amount.zero?
      @message.display_text_highlighted('Operation Canceled')
    elsif record[:current_amount].to_i > withdraw_amount
      if CashDispenser.new.is_sufficient_cash_available(withdraw_amount, cash_atm)
        record[:current_amount] = record[:current_amount].to_i - withdraw_amount
        record[:total_balance] = record[:total_balance].to_i - withdraw_amount
        BankDataBase.new.transaction(record[:account], record[:current_amount], record[:total_balance])
        CashDispenser.new.dispense_cash
        cash_atm - withdraw_amount
      else
        @message.display_text_highlighted_sup('Sorry!')
        @message.display_text_highlighted_inf('In this moment We do not have sufficient cash, try with a smaller amount!')
        false
      end
    else
      @message.display_text_highlighted('You do not have sufficient cash for withdraw, try with a smaller amount!')
      false
    end
  end

  def menu(amount)
    case amount
    when 1 then amount = 20
    when 2 then amount = 40
    when 3 then amount = 60
    when 4 then amount = 100
    when 5 then amount = 200
    when 6 then amount = 0
    else
      @message.display_text_highlighted('The option that you was selected is not exist, try again!!')
      false
    end
  end
end
