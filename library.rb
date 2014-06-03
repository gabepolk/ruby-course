# require 'pry-debugger'

class Book
  attr_reader :author, :title
  attr_accessor :id, :lent_to, :status

  def initialize(title, author)
    @author = author
    @title = title
    @id = nil
    @status = 'available'
    @lent_to = nil
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
    books.last.id = books.length - 1
  end

  def check_out_book(book_id, borrower)
    if books[book_id].status == 'available' && borrower.borrowing == false
      books[book_id].check_out
      books[book_id].lent_to = borrower
      borrower.borrowing = true
      return books[book_id]
    else
      return nil
    end
  end

  def check_in_book(book)
    book.status = 'available'
    book.lent_to = nil
  end

  def get_borrower(book_id)
    books[book_id].lent_to.name
  end

  def available_books
    @books.select {|b| b.status == 'available'}
  end

  def borrowed_books
    @books.select {|b| b.status == 'checked_out'}
  end
end
