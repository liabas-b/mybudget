class OperationsController < ApplicationController
  include AccountsHelper

  def create
    @status = {}

    if params[:operation][:amount].present?
      operation_type = params[:operation][:amount].to_i < 0 ? 'outcomes' : 'incomes'
      params[:operation][:is_recurrent] = params[:operation][:frequency].present?
      @account = Account.find(params[:operation][:account_id])
      @operation = @account.send(operation_type).new(params.require(:operation).permit([:amount, :name, :description, :date, :date_from, :date_to, :is_recurrent, :frequency]))

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

  def destroy
    init_account(params[:account_id])
    @operation = @account.operations.detect{ |w| w.id.to_s == params[:id] }
    @operation.destroy
    init_account(params[:account_id])
    respond_to :js
  end
end
