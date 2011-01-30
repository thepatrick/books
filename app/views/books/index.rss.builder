# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Year of the Book"
    xml.description "One year, 52 books"
    xml.link books_url
    
    for book in @books
      xml.item do
        xml.title book.title
        xml.description book.author
        xml.pubDate book.ended.to_s(:rfc822)
        xml.link book_url(book)
        xml.guid book_url(book)
      end
    end
  end
end