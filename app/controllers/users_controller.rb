
class UsersController < ApplicationController
  def create
    # Create the user from params
    @user = User.new(params[:user])
    if @user.save
      UserMailer.welcome(@user).deliver_now
    end
  end
end

