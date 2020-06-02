class Order < ApplicationRecord
  searchkick

  belongs_to :user
  belongs_to :pack
  validates :category, presence: true
  validates :weight, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  monetize :price_cents

  def search_data
    attributes.merge(
      user_name: user(&:name)
      user_email: user(&:email)
      user_prenom: user(&:prenom)
      user_phone: user(&:phone)
    )
  end
end
