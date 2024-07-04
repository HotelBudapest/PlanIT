class PollsController < ApplicationController
  before_action :set_poll, only: [:destroy]
  before_action :set_event, only: [:create, :destroy]

  def create
    @poll = @event.polls.build(poll_params)
    if @poll.save
      redirect_to @event, notice: "Poll was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @poll.destroy
    redirect_to @event, notice: "Poll was successfully deleted."
  end

  private

  def set_poll
    @poll = Poll.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def poll_params
    params.require(:poll).permit(:title, poll_options_attributes: [:id, :title, :_destroy])
  end
end
