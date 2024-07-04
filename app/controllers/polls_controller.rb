class PollsController < ApplicationController
  before_action :set_poll, only: %i[show edit update destroy]
  before_action :set_event, only: %i[create update]

  def show
    @poll_options = @poll.poll_options.includes(:votes)
  end

  def new
    @poll = Poll.new
    @poll.poll_options.build
  end

  def create
    @poll = @event.polls.build(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @event, notice: "Poll was successfully created." }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @event, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
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
