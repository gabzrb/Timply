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


  def connect_cart
    Cart.create(user: self)
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
