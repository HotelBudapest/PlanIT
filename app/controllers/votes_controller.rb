class VotesController < ApplicationController
  before_action :set_poll_option

  def create
    @vote = @poll_option.votes.build(user: current_user)
    @vote.poll = @poll_option.poll
    if @vote.save
      Rails.logger.info "Vote saved successfully."
      redirect_to @poll_option.poll.event, notice: 'Vote was successfully cast.'
    else
      Rails.logger.error "Vote save failed: #{@vote.errors.full_messages.join(", ")}"
      redirect_to @poll_option.poll.event, alert: 'There was an error casting your vote.'
    end
  end

  private

  def set_poll_option
    @poll_option = PollOption.find(params[:poll_option_id])
  end
end
