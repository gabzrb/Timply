class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pack
  validates :tracking, uniqueness: true
end
