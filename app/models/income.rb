class Income < Operation
  include Mongoid::Document

  embedded_in :account
  embeds_many :simulated_account_operations
end
