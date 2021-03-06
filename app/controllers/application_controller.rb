class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :entreprise, :siret, :phone, :address, :prenom, :codepostal, :ville, :comfirm_data])
    devise_parameter_sanitizer.permit(:account_update, keys: [:entreprise, :siret, :name, :phone, :address, :prenom, :codepostal, :ville])
  end
end
