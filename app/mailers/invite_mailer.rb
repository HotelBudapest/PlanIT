class InviteMailer < ApplicationMailer
    def invite_email
      @user = params[:user]
      @event = params[:event]
      @token = params[:token]
      @invite_link = join_event_url(@event, token: @token)
      mail(to: @user.email, subject: 'You are invited to an event')
    end
  end
  