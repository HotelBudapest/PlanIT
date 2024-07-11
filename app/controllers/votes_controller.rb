class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_and_poll_option
  before_action :authorize_user!

  def create
    @vote = @poll_option.votes.build(user: current_user)
    @vote.poll = @poll_option.poll

    if @poll_option.votes.where(user: current_user).exists?
      redirect_to @poll_option.poll.event, alert: 'You have already voted for this option.'
    elsif @vote.save
      redirect_to @poll_option.poll.event, notice: 'Vote was successfully cast.'
    else
      redirect_to @poll_option.poll.event, alert: 'There was an error casting your vote.'
    end
  end

  def destroy
    @vote = @poll_option.votes.find_by(user: current_user)
    if @vote.destroy
      redirect_to @poll_option.poll.event, notice: 'Vote was successfully removed.'
    else
      redirect_to @poll_option.poll.event, alert: 'There was an error removing your vote.'
    end
  end

  private

  def set_event_and_poll_option
    @event = Event.find(params[:event_id])
    @poll = @event.polls.find(params[:poll_id])
    @poll_option = @poll.poll_options.find(params[:poll_option_id])
  end

  def authorize_user!
    unless @event.creator == current_user || @event.attendees.exists?(id: current_user.id)
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
