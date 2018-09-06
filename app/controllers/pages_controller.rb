class PagesController < ApplicationController

  attr_accessor :score
  def index
    @article = Article.all.reverse_order
    ids = REDIS.zrevrangebyscore "articles", "+inf", 0
    @ranking_articles = ids.map{ |id| Article.find(id) }
    @ranking_scores = []
    @ranking_articles.each do |article|
      score = REDIS.zscore "articles", article.id
      score = score.to_i
      @ranking_scores.push(score)
    end
  end
end
