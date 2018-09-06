class PagesController < ApplicationController
  def index
    @article = Article.all.reverse_order
    ids = REDIS.zrevrangebyscore "articles", "+inf", 0
    @ranking_articles = ids.map{ |id| Article.find(id) }
  end
end
