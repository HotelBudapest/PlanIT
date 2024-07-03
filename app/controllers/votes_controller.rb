class VotesController < ApplicationController
  before_action :set_poll

  def create
    @vote = @poll.votes.build(vote_params)
    @vote.user = current_user

    if @vote.save
      redirect_to event_path(@poll.event), notice: "Your vote has been recorded."
    else
      redirect_to event_path(@poll.event), alert: "Unable to record your vote."
    end
  end

  private

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end

  def vote_params
    params.require(:vote).permit(:option)
  end
end
