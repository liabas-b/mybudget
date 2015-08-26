class AccountsController < ApplicationController
  include AccountsHelper

  def show
    init_account(params[:id])
  end

  def sold_at
    @account = Account.find(params[:id])
    @simulation_date = Date.parse(params[:simulation][:date])
    respond_to :js
  end
end
