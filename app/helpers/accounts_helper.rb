module AccountsHelper

  def init_account(id)
    @account = Account.find(id)
    @operations = @account.operations
    @new_operation = Operation.new
    @frequencies_for_select = [['Ponctuelle', nil], ['Annuelle', 'yearly'], ['Mensuelle', 'monthly'], ['Quotidienne', 'daily']]
  end
end
