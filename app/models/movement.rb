class Movement < ApplicationRecord
    includes ActiveModel::Validations
    
    validates :asset_id, presence: true
    validates :concept, presence: true
    validates :original_amount, presence: true
    validates :original_currency, presence: true
    validates :movement_date, presence: true
    validates :settled_date, presence: true

    belongs_to :asset
    belongs_to :category, optional: true
end
