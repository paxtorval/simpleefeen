class Asset < ApplicationRecord
    includes ActiveModel::Validations
    
    validates :kind, presence: true
    validates :country, presence: true
    validates :currency, presence: true
    validates :name, presence: true

    enum :kind, [:bank_account, :stock_plan, :pension_plan]

    has_many :movements, dependent: :destroy
end
