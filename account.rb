
class Account
  attr_accessor :account_number, :pin, :available_balance, :total_balance

  def validate_pin(user_pin)
    if pin == user_pin
      true
    else
      false
    end
  end

  def credit(amount)
    total_balance(total_balance.to_f + amount.to_f)
  end

  def debit(amount)
    available_balance(available_balance.to_f - amount.to_f)
    total_balance(total_balance.to_f + amount.to_f)
  end
end
