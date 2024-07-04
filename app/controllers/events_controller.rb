class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :invite]
  before_action :authorize_user!, only: [:edit, :update, :destroy, :invite]

  def index
    @created_events = current_user.created_events
    @invited_events = current_user.events
  end

  def show
    @poll = Poll.new
    @poll_options = @event.polls.includes(:poll_options)
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
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  def invite
    user = User.find_by(email: params[:user_email])
    if user && !@event.attendees.include?(user)
      @event.attendees << user
      redirect_to @event, notice: "#{user.email} has been invited."
    else
      redirect_to @event, alert: "Unable to invite user."
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    redirect_to events_path, alert: 'You are not authorized to perform this action.' unless @event.creator == current_user
  end

  def event_params
    params.require(:event).permit(
      :title, 
      :description, 
      :location, 
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
