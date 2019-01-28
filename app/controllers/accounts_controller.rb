class AccountsController < ApplicationController
  before_filter :init_accounts
  before_filter :frequencies_for_select, only: [:show]

  def show
    init_account(params[:id])
    @default_simulation_date = Date.today.end_of_month
    @operation = Operation.new(account_id: @account.id)
  end

  def update
    @account = Account.find(params[:id])

     if @account.update(params.require(:account).permit([:name, :sold]))
      @account.update(sold_date: DateTime.now)
    end
    respond_to :js
  end

  def sold_at
    @account = Account.find(params[:id])
    @simulation_date = params[:simulation][:date].present? ? Date.parse(params[:simulation][:date]) : Date.today
    @simulated_sold = @simulation_date.present? ? @account.sold_at(@simulation_date) : nil
    respond_to :js
  end

  def new
    @new_account = Account.new(sold: 0, sold_date: Date.today)
  end

  def create
    @account = Account.create(params.require(:account).permit(:name, :description, :sold).merge(sold_date: Date.today))
    if @account.errors.blank?
      redirect_to account_path(@account)
    end
  end
end
