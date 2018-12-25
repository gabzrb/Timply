class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pack
  validates :category, presence: true
  validates :weight, presence: true
  validates :quantity, presence: true
  monetize :price_cents
end
