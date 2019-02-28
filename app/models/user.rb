class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
  has_many :orders,
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true

  after_create :welcome_user




  def welcome_user
    UserNotifier.welcome_user(self).deliver
    redirect_to root_path
  end
end
