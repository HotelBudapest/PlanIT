class PollOptionsController < ApplicationController
    before_action :set_event_and_poll
    before_action :authorize_user!
  
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
      @poll_option = @poll.poll_options.find(params[:id])
    end
  
    def update
      @poll_option = @poll.poll_options.find(params[:id])
      if @poll_option.update(poll_option_params)
        redirect_to @event, notice: 'Poll option was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @poll_option = @poll.poll_options.find(params[:id])
      @poll_option.destroy
      redirect_to @event, notice: 'Poll option was successfully deleted.'
    end
  
    private
  
    def set_event_and_poll
      @event = Event.find(params[:event_id])
      @poll = Poll.find(params[:poll_id])
    end
  
    def authorize_user!
      unless @event.attendees.include?(current_user) || @event.creator == current_user
        redirect_to events_path, alert: 'You are not authorized to perform this action.'
      end
    end
  
    def poll_option_params
      params.require(:poll_option).permit(:title)
    end
  end
  