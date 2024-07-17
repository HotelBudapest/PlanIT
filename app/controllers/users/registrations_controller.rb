# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :combine_phone_number, only: [:create, :update]
  before_action :split_phone_number, only: [:edit]
  before_action :authenticate_user!, only: [:destroy]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  # 
  #
  
  def destroy
    @user = current_user

    if @user.valid_password?(params[:user][:current_password])
      super
    else
      flash[:alert] = "Current password is incorrect."
      redirect_to edit_user_registration_path
    end
  end

  private

  def combine_phone_number
    if params[:user][:phone_number].present? && params[:country_code].present?
      params[:user][:phone_number] = "#{params[:country_code]}#{params[:user][:phone_number]}"
    end
  end

  def split_phone_number
    if resource.phone_number.present?
      match = resource.phone_number.match(/^(\+\d{1,3})(\d+)$/)
      if match
        @country_code = match[1]
        @local_phone_number = match[2]
      else
        @country_code = ''
        @local_phone_number = resource.phone_number
      end
    else
      @country_code = ''
      @local_phone_number = ''
    end
  end

end