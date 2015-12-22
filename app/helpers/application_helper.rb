module ApplicationHelper

  def init_accounts
    @accounts = Account.all
  end
end
