class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @event, notice: 'Comment was successfully created.'
    else
      redirect_to @event, alert: 'There was an error adding your comment.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
