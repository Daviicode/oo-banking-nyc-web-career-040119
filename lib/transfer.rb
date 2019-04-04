class Transfer
  # your code here
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if self.status == "pending" && self.valid?
      # now we know that the status is pending and the transaction is 'valid'

      if sender.balance >= @amount
        # now we know the sender account balance is large enough to transfer the amount
        sender.balance -= @amount
        receiver.balance += @amount
        self.status = "complete"

      else
        # now we know that the account did not have the balance to make the transfer
        self.status = "rejected"
        "Transaction rejected. Please check your account balance."
      end

    else
      # now we know the status is not pending
      self.status = "rejected"
    end
  end

  def reverse_transfer
    if self.status == "complete"
      sender.balance += @amount
      receiver.balance -= @amount
      self.status = "reversed"
    end
  end



end
