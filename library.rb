# require 'pry-debugger'

class Book
  attr_reader :author, :title
  attr_accessor :id, :lentto, :status

  def initialize(title, author)
    @author = author
    @title = title
    @id = nil
    @status = 'available'
    @lentto = nil
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else
      return false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
    end
  end

end

class Borrower
  attr_reader :name
  attr_accessor :borrowing

  def initialize(name)
    @name = name
    @borrowing = false
  end
end

class Library
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(title, author)
    books << Book.new(title, author)
    books.last.id = books.length
  end

  def check_out_book(book_id, borrower)
    if books[book_id - 1].status == 'available' && borrower.borrowing == false
      books[book_id - 1].check_out
      books[book_id - 1].lentto = borrower
      borrower.borrowing = true
      return books[book_id - 1]
    else
      return nil
    end
  end

  def check_in_book(book)
    book.status = 'available'
    book.id = nil
    book.lentto = nil
  end

  def get_borrower(book_id)
    books[book_id -1].lentto.name
  end

  def available_books
    books_available = []
    @books.each do |book|
      if book.status == 'available'
        books_available << book
      end
    end
    return books_available
  end

  def borrowed_books
    books_borrowed = []
    @books.each do |book|
      if book.status == 'checked_out'
        books_borrowed << book
      end
    end
    return books_borrowed
  end
end
