class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :current_user?, only: [:edit, :update, :destroy]
  # 投稿を編集するときにその投稿をした人だけが編集できる

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    REDIS.zincrby "articles", 1, @article.id
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    redirect_to root_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to root_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  private

    def article_params
      params.require(:article).permit(:title, :body,)
    end

    def current_user?
      currnt_user.id == Article.find(params[:id]).user_id
    end
end
