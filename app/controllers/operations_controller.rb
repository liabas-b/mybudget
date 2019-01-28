class OperationsController < ApplicationController
  include AccountsHelper
  before_filter :frequencies_for_select, only: [:edit]

  def create
    @status = {}

    if params[:operation][:amount].present?
      operation_type = params[:operation][:amount].to_i < 0 ? 'outcomes' : 'incomes'
      params[:operation][:is_recurrent] = params[:operation][:frequency].present?
      @account = Account.find(params[:operation][:account_id])
      @operation = @account.send(operation_type).new(permitted_params)

      if @operation.save
        @status[:success] = "Operation enregistree"
        @operations = @account.operations
        @new_operation = Operation.new
        init_account(@account.id)
      else
        @status[:errors] = @operation.errors.messages.map{|k,v| k.to_s.downcase}
      end
    else
      @status[:errors] = ['amount']
    end

    respond_to :js
  end

  def edit
    @operation = Operation.find(params[:id])
    respond_to :js
  end

  def update
    @operation = Operation.find(params[:id])
    if @operation.update(permitted_params)
      init_account(@operation.account_id)
    end
    respond_to :js
  end

  def destroy
    @operation = Operation.find(params[:id])
    account_id = @operation.account_id
    @operation.destroy
    init_account(account_id)
    respond_to :js
  end

  private

  def permitted_params
    params.require(:operation).permit(:account_id, :amount, :name, :description, :date, :date_from, :date_to, :is_recurrent, :frequency)
  end
end
