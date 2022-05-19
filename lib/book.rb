
class Book
  attr_reader :id
  attr_accessor :title, :author

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      author = book.fetch("author")
      id = book.fetch("id").to_i
      books.push(Book.new({:title => title, :author => author,:id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(book_to_compare)
    self.title() == book_to_compare.title()
  end

  def self.clear
    DB.exec("DELETE FROM books *;")
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    if book
    title = book.fetch("title")
    author = book.fetch("author")
    id = book.fetch("id").to_i
    Book.new({:title => title, :author => author, :id => id})
    else 
      nil
    end
  end

  def update(title)
    @title = title
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
    DB.exec("DELETE FROM checkouts WHERE books_id = #{@id};")
  end
end

