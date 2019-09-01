class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def create
    @gram = Gram.find_by_id(params[:gram_id])
    if @gram.blank?
      return render_not_found if @gram.blank?
    end
    @gram.comments.create(comment_params.merge(user: current_user))
    redirect_to root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:message)
  end
  def gram_params
    params.require(:comment).permit(:message,:user_id,:gram_id)
  end
  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end
end
