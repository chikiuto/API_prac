class BooksController < ApplicationController
  def index
      ## 今回は例としてpythonに関する本を検索していく。
      @books = RakutenWebService::Books::Book.search(title: "Python")
  end
end
