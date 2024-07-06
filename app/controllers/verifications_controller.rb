class VerificationsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      if current_user.confirmed?
        redirect_to root_path, notice: 'Your account is already confirmed.'
      else
        # Render the verification page or send the verification code
      end
    end
  
    def create
      if current_user.verification_code == params[:verification_code]
        current_user.update(verified: true)
        redirect_to root_path, notice: 'Your account has been successfully verified.'
      else
        flash.now[:alert] = 'Invalid verification code.'
        render :new
      end
    end
  end
  