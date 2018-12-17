class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pack
  monetize :price_cents
end
