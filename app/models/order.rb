class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pack
  validates :category, presence: true
  validates :weight, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  monetize :price_cents

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :price, :state, :pack_sku ],
    associated_against: {
      user: [ :name, :email, :prenom, :phone ]
    },
    using: {
      tsearch: { prefix: true }
    }

end

