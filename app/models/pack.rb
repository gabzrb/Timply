class Pack < ApplicationRecord
  has_many :orders
  serialize :category
end
