class Order < ApplicationRecord
  searchkick

  belongs_to :user
  belongs_to :pack
  validates :category, presence: true
  validates :weight, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  monetize :price_cents
end
