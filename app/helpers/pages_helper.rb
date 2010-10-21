module PagesHelper
  def news_article_title title, link
    link_to(truncate(title,:length => 50),link,:target => "_none")
  end
  
  def news_article_snippet text
    truncate(text, :length => 120)
  end
end