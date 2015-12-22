class ApplicationController < ActionController::Base
  include ApplicationHelper
  include AccountsHelper

  protect_from_forgery with: :exception
end
