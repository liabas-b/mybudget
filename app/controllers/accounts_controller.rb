class AccountsController < ApplicationController
  include AccountsHelper

  def show
    init_account(params[:id])
  end

  def sold_at
    @account = Account.find(params[:id])
    @simulation_date = params[:simulation][:date].present? ? Date.parse(params[:simulation][:date]) : Date.today
    @simulated_sold = @simulation_date.present? ? @account.sold_at(@simulation_date) : nil
    respond_to :js
  end
end
