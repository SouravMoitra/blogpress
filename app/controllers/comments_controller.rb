class CommentsController < ApplicationController
  before_action :user_signed_in, only: [:create, :destroy]

  def create
    @article = Article.friendly.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.friendly.find(params[:article_id])
    comment = @article.comments.find(params[:id])
    comment.destroy
    redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
