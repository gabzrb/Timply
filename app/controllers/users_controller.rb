
class UsersController < ApplicationController
  def create
    # Create the user from params
    @user = User.new(params[:user])
    if @user.save
      UserMailer.welcome(@user).deliver_now
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :entreprise, :siret, :phone, :address, :prenom, :codepostal, :ville, :comfirm_data, :email)
  end
end

