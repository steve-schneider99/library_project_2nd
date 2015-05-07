require('spec_helper')

describe(Book) do

  describe('#title') do
    it('will return the title of a book') do
      book = Book.new({:title => "Harry Potter", :author => "JK Rowling", :id => nil})
      expect(book.title()).to(eq("Harry Potter"))
    end
  end

  describe('#author') do
    it('will return the author of a book') do
      book = Book.new({:title => "Harry Potter", :author => "JK Rowling", :id => nil})
      expect(book.author()).to(eq("JK Rowling"))
    end
  end

  describe('#id') do
    it('will return the id of a book') do
      book = Book.new({:title => "Harry Potter", :author => "JK Rowling", :id => nil})
      expect(book.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe ('.all_books') do
    it('will return empty at first') do
      expect(Book.all_books()).to(eq([]))
    end
  end

  describe('.find') do
    it('return a book by its id number') do
      test_book = Book.new({:title => "Atlas Shrugged", :author => "Ayn Rand", :id => nil})
      test_book.save()
      test_book2 = Book.new({:title => "The Dark Tower", :author => "Stephen King", :id => nil})
      test_book2.save()
      expect(Book.find(test_book.id())).to(eq(test_book))
    end
  end

  describe('#save') do
    it('saves a book to the books table') do
      test_book = Book.new({:title => "Atlas Shrugged", :author => "Ayn Rand", :id => nil})
      test_book.save()
      expect(Book.all_books()).to(eq([test_book]))
    end
  end

  describe('#==') do
    it('is the same book if it has the same title, author, and id') do
      test_book = Book.new({:title => "Enders Game", :author => "Orson Scott Card", :id => nil})
      test_book2 = Book.new({:title => "Enders Game", :author => "Orson Scott Card", :id => nil})
      expect(test_book).to(eq(test_book2))
    end
  end

  describe('#update') do
    it('lets you update books in the database') do
      test_book = Book.new({:title => 'Harry Potter', :author => 'JK Rowling', :id => nil})
      test_book.save()
      test_book.update({:title => 'Harry Putter'})
      expect(test_book.title()).to(eq('Harry Putter'))
    end
  end

  describe('#delete') do
    it('lets you delete a book from the database') do
      test_book = Book.new({:title => 'Harry Putter', :author => 'JK Rowling', :id => nil})
      test_book.save()
      test_book2 = Book.new({:title => 'Lord Of The Rings', :author => 'JRR Tolkien', :id => nil})
      test_book2.save()
      test_book.delete()
      expect(Book.all_books()).to(eq([test_book2]))
    end
  end


end
