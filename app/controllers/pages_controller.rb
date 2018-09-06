class PagesController < ApplicationController
  def index
    @article = Article.all
  end
end
