class PollOptionsController < ApplicationController
    before_action :set_event_and_poll
  
    def new
      @poll_option = @poll.poll_options.build
    end
  
    def create
      @poll_option = @poll.poll_options.build(poll_option_params)
      if @poll_option.save
        redirect_to @event, notice: 'Poll option was successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def set_event_and_poll
      @event = Event.find(params[:event_id])
      @poll = Poll.find(params[:poll_id])
    end
  
    def poll_option_params
      params.require(:poll_option).permit(:title)
    end
  end
  