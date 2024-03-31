class Category < ApplicationRecord
  includes ActiveModel::Validations

  validates :name, presence: true

  has_many :movements, dependent: :destroy
end
