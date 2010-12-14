class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to(:back, :notice => t("comment.create.success"))
    else
      err_msg = t("comment.create.error") 
      err_msg += @comment.errors.full_messages.to_sentence
      redirect_to(:back, :notice => err_msg)
    end
  end
end
