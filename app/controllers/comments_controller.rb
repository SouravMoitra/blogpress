class CommentsController < ApplicationController
  before_action :user_signed_in, only: [:create, :destroy]

  def create
    @article = Article.friendly.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    @comments = @article.comments.paginate(:page => params[:page], per_page: 5).order("created_at DESC")
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def destroy
    @article = Article.friendly.find(params[:article_id])
    comment = @article.comments.find(params[:id])
    comment.destroy
    @comments = @article.comments.paginate(:page => params[:page], per_page: 5).order("created_at DESC")
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
