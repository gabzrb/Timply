
class UsersController < ApplicationController
  def create
    # Create the user from params
    @user = User.new(params[:user])
  end
end
