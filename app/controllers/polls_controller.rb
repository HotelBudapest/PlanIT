class PollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :authorize_user!

  def create
    @poll = @event.polls.build(poll_params)
    if @poll.save
      redirect_to @event, notice: 'Poll was successfully created.'
    else
      redirect_to @event, alert: 'There was an error creating the poll.'
    end
  end

  def destroy
    @poll = @event.polls.find(params[:id])
    @poll.destroy
    redirect_to @event, notice: 'Poll was successfully deleted.'
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def authorize_user!
    unless @event.creator == current_user || @event.attendees.include?(current_user)
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def poll_params
    params.require(:poll).permit(:title, poll_options_attributes: [:id, :title, :_destroy])
  end
end
