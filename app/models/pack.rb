class Pack < ApplicationRecord
  has_many :orders
  serialize :infos
end
