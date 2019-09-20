class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  validates :name, presence: true
  validates :prenom, presence: true
  validates :address, presence: true
  after_create :send_welcome_email
  after_create :connect_cart
  has_one :cart, dependent: :destroy

  private

  def connect_cart
    Cart.create(user: self)
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
