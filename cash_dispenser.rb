require_relative './screen'

class CashDispenser
  def initialize
    @message = Screen.new
  end

  def dispense_cash
    @message.display_line_message("\n==================================")
    @message.display_line_message("\nPlease take your money!")
    @message.display_line_message("\n==================================\n")
  end

  def is_sufficient_cash_available(amount, count)
    amount <= count
  end
end
