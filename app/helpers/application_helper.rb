module ApplicationHelper

  def init_accounts
    @accounts = Account.all
  end

  def frequencies_for_select
    @frequencies_for_select = Operation::FREQUENCIES.map { |f| [I18n.t("frequency.#{f}").titlecase, f] }
  end
end
