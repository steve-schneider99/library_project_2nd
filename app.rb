require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => "library_project_test"})

get('/') do
  @patrons = Patron.all_patrons()
  erb(:index)
end

get('/librarian_books') do
  @books = Book.all_books()
  erb(:librarian_books)
end

post('/add_book') do
  title = params.fetch("title")
  author = params.fetch("author")
  new_book = Book.new({:title => title, :author => author, :id => nil})
  new_book.save()
  @books = Book.all_books()
  erb(:librarian_books)
end

get('/librarian_book/:id') do
  @book = Book.find(params.fetch("id").to_i())
  erb(:librarian_book)
end

patch('/book/:id') do
  title = params.fetch("title")
  author = params.fetch("author")
  # if title == "" {title = nil}
  # if author == "" {author = nil}
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title => title, :author => author})
  erb(:librarian_book)
end

delete('/book/:id') do
  @book = Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all_books()
  erb(:librarian_books)
end

get('/patron/:id') do
  @patron = Patron.find(params.fetch('id').to_i())
  erb(:patron_books)
end

post('/new_patron') do
  name = params.fetch("name")
  new_patron = Patron.new({:name => name, :id => nil})
  new_patron.save()
  @patrons = Patron.all_patrons()
  erb(:index)
end

get('/author_results') do
end
