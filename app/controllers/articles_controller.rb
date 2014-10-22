class ArticlesController < ApplicationController

  before_action :user_signed_in, except: [:index, :show]

  def index
    @articles = Article.all.order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article updated"
      redirect_to :@article
    else
      render 'new'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    flash[:info] = "Article deleted"
    redirect_to articles_url
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def user_signed_in
    unless user_signed_in?
      flash[:error] = "Sign in first"
      redirect_to root_url
    end
  end
end
