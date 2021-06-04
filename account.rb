class Account
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
      true
    else
      @message.display_line_message("\nUser number or Pin Incorrect, try agan!\n\n")
      false
    end
  end
end
