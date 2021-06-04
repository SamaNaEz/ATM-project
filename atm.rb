require_relative './keypad'
require_relative './screen'
require_relative './bank_data_base'
require_relative './balance_inquiry'
require_relative './withdrawal'
require_relative './deposit'
require_relative './cash_dispenser'

class ATM

  def initialize
    @user_authenticated = false
    @message = Screen.new
    @in_user = Keypad.new
    @current_account_number = 0
    @cash_dispenser_amoun = 500
  end

  def authenticate_user(usr, pss)
    authenticate_user_bank = BankDataBase.new

    record = authenticate_user_bank.records.find do |r|
      if r[:account].to_i == usr
        r
      else
        nil
      end
    end
    if !record.nil? && record[:secret].to_i == pss
      @current_account_number = usr
      @user_authenticated = true
    else
      @message.display_line_message("\nUser number or Pin Incorrect, try agan!\n\n")
      @user_authenticated = false
    end
  end

  def main_menu
    @message.display_line_message("\nMain Menu\n")
    @message.display_line_message("\n1.- View my balance")
    @message.display_line_message("\n2.- Withdraw cash")
    @message.display_line_message("\n3.- Deposit funds")
    @message.display_line_message("\n4.- Exit")
    @message.display_line_message("\nEnter a choice: ")
    @in_user.input
  end

  def withdraw_menu
    @message.display_line_message("\nWithdrawal menu\n")
    @message.display_line_message("\n1.- $20")
    @message.display_line_message("\n2.- $40")
    @message.display_line_message("\n3.- $60")
    @message.display_line_message("\n4.- $100")
    @message.display_line_message("\n5.- $200")
    @message.display_line_message("\n6.- Cancel transaction")
    @message.display_line_message("\nEnter a choice: ")
    @in_user.input
  end

  def restart
    @message.display_text_highlighted('Thanks for use us services!')
    @user_authenticated = false
    @current_account_number = 0
    @cash_dispenser_amoun = 500
  end

  def clear
    @user_authenticated = true
  end

  def execute
    loop do
      until @user_authenticated
        @message.display_line_message("Welcome!\n")
        @message.display_line_message('Ingrese usuario: ')
        usr = @in_user.input
        @message.display_line_message('Ingrese pin: ')
        pss = @in_user.input
        authenticate_user(usr, pss)
      end

      main_menu_option = main_menu
      case main_menu_option
      when 1 then BalanceInquiry.new.execute(@current_account_number)
      when 2
        loop do
          withdraw_status = Withdrawal.new.execute(withdraw_menu, @current_account_number, @cash_dispenser_amoun)
          if withdraw_status != false
            @cash_dispenser_amoun = withdraw_status
            break
          end
        end
      when 3
        @message.display_line_message("\nPlease enter the amount of your deposit: ")
        deposit_amount = @in_user.input
        Deposit.new.execute(deposit_amount, @current_account_number)
      when 4 then restart
      else
        @message.display_line_message("\nThe option that you was selected is not exist, try again!!")
        restart
      end
    end
  end
end

atm = ATM.new
atm.execute
