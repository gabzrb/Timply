class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pack
  validates :category, presence: true
  validates :weight, presence: true
  validates :quantity, presence: true, :numericality => { greater_than: 9 }
  monetize :price_cents
end
