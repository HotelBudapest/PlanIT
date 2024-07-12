class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :authorize_user!

  def create
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @event, notice: 'Comment was successfully added.'
    else
      redirect_to @event, alert: 'There was an error adding your comment.'
    end
  end

  def pin
    @comment = @event.comments.find(params[:id])
    @comment.update(pinned: !@comment.pinned)
    redirect_to @event, notice: 'Comment pin status was successfully updated.'
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def authorize_user!
    unless @event.creator == current_user || @event.event_users.exists?(user_id: current_user.id)
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
