class Patron
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      
      id = patron.fetch("id").to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:patron_name)) && (attributes.fetch(:patron_name) != nil)
      patron_name = attributes.fetch(:patron_name)
      patron = DB.exec("SELECT * FROM patrons WHERE lower(name)='#{patrons_name.downcase}';").first
      if patron != nil
        DB.exec("INSERT INTO checkouts (book_id, patron_id) VALUES (#{book['id'].to_i}, #{@id});")
      end
    end
  end

  def books
    books = []
    results = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{@id};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      books.push(Book.new({:title => title, :author => author, :id => book_id}))
    end
    books
  end

  def ==(patron_to_compare)
    self.name() == patron_to_compare.name()
  end

  def save
    results = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first().fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM patrons *;")
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
    DB.exec("DELETE FROM checkouts WHERE patron_id = #{@id};")
    end
  end

# def delete
  #   DB.exec("SELECT * FROM patrons WHERE id =#{id};").first
  #   if patrons
  #     name = patrons.fetch("name")
  #     id = patrons.fetch("id").to_i
  #     Patron.new({:name => name, :id => id})
  #   else
  #     nil
  #   end
  # end

  # create checkout method? 
# take a book as an argument, pat calling (), creating new row on chekout table