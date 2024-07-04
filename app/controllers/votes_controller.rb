class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_poll_option
  before_action :authorize_user!

  def create
    @vote = @poll_option.votes.build(user: current_user)
    @vote.poll = @poll_option.poll
    if @vote.save
      redirect_to @poll_option.poll.event, notice: 'Vote was successfully cast.'
    else
      redirect_to @poll_option.poll.event, alert: 'There was an error casting your vote.'
    end
  end

  private

  def set_poll_option
    @poll_option = PollOption.find(params[:poll_option_id])
  end

  def authorize_user!
    unless @poll_option.poll.event.creator == current_user || @poll_option.poll.event.attendees.include?(current_user)
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
