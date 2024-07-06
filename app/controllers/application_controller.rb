class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :check_verification
  
    def check_verification
      return if current_user.nil? || current_user.confirmed?
  
      redirect_to new_verification_path(email: current_user.email) unless current_user.verified?
    end
  end
  