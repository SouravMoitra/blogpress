class ArticlesController < ApplicationController

  before_action :user_signed_in, except: [:index, :show]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :author_signin_status, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:tag]
      @articles = Article.paginate(:page => params[:page], per_page: 5).tagged_with(params[:tag])
    else
      @articles = Article.paginate(:page => params[:page], per_page: 5).order("created_at DESC")
    end
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
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article updated"
      redirect_to @article
    else
      render 'new'
    end
  end

  def destroy
    article.destroy
    flash[:info] = "Article deleted"
    redirect_to articles_url
  end

  def show
    @article = Article.friendly.find(params[:id])
    @comments = @article.comments.paginate(:page => params[:page], per_page: 5).order("created_at DESC")
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :tag_list)
  end

  def check_user
    @article = Article.friendly.find(params[:id])
    unless @article.user == current_user
      flash[:danger] = "You dont have permission to edit/destroy"
      redirect_to @article
    end
  end
end
