class Movement < ApplicationRecord
    includes ActiveModel::Validations
    
    validates :concept, presence: true
    validates :description, presence: true
    validates :original_amount, presence: true
    validates :original_currency, presence: true
    validates :movement_date, presence: true
    validates :settled_date, presence: true

end
