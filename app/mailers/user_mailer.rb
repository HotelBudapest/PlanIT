class UserMailer < ApplicationMailer
    def verification_email(user)
      @user = user
      mail(to: @user.email, subject: 'Email Verification')
    end
end
  