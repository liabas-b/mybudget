module AccountsHelper

  def init_account(id)
    @account = Account.find(id)
    @operations = @account.operations
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @simulated_sold = @date.present? ? @account.sold_at(@date) : nil
    @new_operation = Operation.new
    @frequencies_for_select = [['Ponctuelle', nil], ['Annuelle', 'yearly'], ['Mensuelle', 'monthly'], ['Quotidienne', 'daily']]
  end
end
