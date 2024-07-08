class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :invite, :join]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]

  def index
    @created_events = current_user.created_events
    @invited_events = current_user.events.where.not(creator: current_user)
  end  

  def show
    @poll = Poll.new
    @poll_options = @event.polls.includes(:votes)
    @comments = @event.comments.includes(:user)
    event_user = @event.event_users.find_or_initialize_by(user: current_user)
    if event_user.token.blank?
      event_user.token = SecureRandom.hex(10)
      event_user.save!
    end
  end  

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @event.polls.each do |poll|
        poll.poll_options.each do |option|
          option.votes.destroy_all
        end
        poll.destroy
      end
      @event.comments.destroy_all
      @event.event_users.destroy_all
      @event.destroy
    end
  
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to events_url, alert: 'Failed to destroy event due to associated records.'
  end
  

  def invite
    user = User.find_by(email: params[:user_email])
    if user && !@event.attendees.include?(user)
      event_user = @event.event_users.find_or_create_by(user: user)
      event_user.update!(token: SecureRandom.hex(10)) unless event_user.token.present?
      InviteMailer.with(user: user, event: @event, token: event_user.token).invite_email.deliver_later
      redirect_to @event, notice: "#{user.email} has been invited."
    else
      redirect_to @event, alert: "Unable to invite user."
    end
  end
  
  def join
    event_user = @event.event_users.find_by(token: params[:token])
    if event_user.present?
      event_user.update!(user: current_user)
      redirect_to @event, notice: 'You have successfully joined the event.'
    else
      redirect_to root_path, alert: 'Invalid invitation link.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    unless @event.creator == current_user || @event.event_users.exists?(user_id: current_user.id)
      redirect_to root_path, alert: 'You are not authorized to view this event.'
    end
  end  

  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :location,
      :location_link,
      :start_time,
      :end_time,
      :image,
      polls_attributes: [
        :id,
        :title,
        :_destroy,
        poll_options_attributes: [
          :id,
          :title,
          :_destroy
        ]
      ]
    )
  end
end
