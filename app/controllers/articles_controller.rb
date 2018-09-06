class ArticlesController < ApplicationController
  before_action :authenticate_user!
  # 投稿を編集するときにその投稿をした人だけが編集できる

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    redirect_to root_path
  end

  def edit
  end

  private

    def article_params
      params.require(:article).permit(:title, :body,)
    end
end
