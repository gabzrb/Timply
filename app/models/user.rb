class User < ApplicationRecord
  include PgSearch::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true
  validates :prenom, presence: true
  validates :address, presence: true
  validates :codepostal, presence: true
  validates :ville, presence: true
  after_create :send_welcome_email
  after_create :connect_cart


  def connect_cart
    Cart.create(user: self)
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
