class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :check_verification
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number])
    end
  
    def check_verification
      return if current_user.nil? || current_user.confirmed?
  
      redirect_to new_verification_path(email: current_user.email) unless current_user.verified?
    end
  end
  