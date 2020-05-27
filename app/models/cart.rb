class Cart < ApplicationRecord
  belongs_to :user
  has_many :orders

  LOGO = 'https://i.ibb.co/qscJhRm/logo.png'
end
