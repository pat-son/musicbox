class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = (current_user).id
    if @comment.save
      respond_to do |format|
        msg = { message: 'Success!', comment_html: render_to_string(@comment) }
        format.json  { render json: msg, status: 'ok' }
      end
    else
      respond_to do |format|
        msg = { message: @comment.errors.full_messages }
        format.json  { render json: msg, status: 500 }
      end
    end
  end

  private
    def comment_params
      params.permit(:content, :creation_id)
    end
end
