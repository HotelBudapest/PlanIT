class PollOptionsController < ApplicationController
    before_action :set_event_and_poll
    before_action :set_poll_option, only: [:edit, :update, :destroy]
  
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
  
    def edit
    end
  
    def update
      if @poll_option.update(poll_option_params)
        redirect_to @event, notice: 'Poll option was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @poll_option.destroy
      redirect_to @event, notice: 'Poll option was successfully deleted.'
    end
  
    private
  
    def set_event_and_poll
      @event = Event.find(params[:event_id])
      @poll = Poll.find(params[:poll_id])
    end
  
    def set_poll_option
      @poll_option = @poll.poll_options.find(params[:id])
    end
  
    def poll_option_params
      params.require(:poll_option).permit(:title)
    end
  end
  