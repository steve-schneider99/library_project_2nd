class Book
attr_reader(:title, :author, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id).to_i
  end

  define_singleton_method(:all_books) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      id = book.fetch('id')
      books.push(Book.new({:title => title, :author => author, :id => id}))
    end
    books
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM books WHERE id = #{@id};")
    @title = result.first().fetch('title')
    @author = result.first().fetch('author')
    Book.new({:title => @title, :author => @author, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |another_title|
    self.title().==(another_title.title()).&(self.id().==(another_title.id())).&(self.author().==(another_title.author()))
  end

  define_method(:update) do |attributes|
    @title = attributes[:title] ||= @title
    @author = attributes[:author] ||= @author
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET author = '#{@author}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

end
