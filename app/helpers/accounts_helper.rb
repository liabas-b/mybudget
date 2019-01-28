module AccountsHelper

  def init_account(id)
    @account = Account.find(id)
    @operations = @account.operations.order(amount: :desc, date: :asc)
    @new_operation = Operation.new
  end
end
