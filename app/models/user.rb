class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true




  private

  after_create :send_signup_email
  private

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver_now
  end
end
