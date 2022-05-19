require('spec_helper')

describe('Book') do

  describe('.all') do
    it('returns an empty array when there are no books') do
    expect(Book.all).to(eq([]))
    end
  end

  describe('#save') do
    it("returns an empty array when there are no books") do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same book if it has the same attributes as another book") do
      book = Book.new(:title => "House of Leaves", :author => "author", :id => nil)
      book2 = Book.new(:title => "House of Leaves", :author => "author", :id => nil)
      expect(book).to(eq(book2))
    end
  end

  describe('.clear') do
    it("clears all books") do
      book = Book.new(:title => "House of Leaves", :author => "author", :id => nil)
      book.save()
      book2 = Book.new(:title => "Another Roadside Attraction", :author => "author", :id => nil)
      book2.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end

  describe('.find') do
    it("finds a book by id") do
      book = Book.new(:title => "Return of the Jedi", :author => "author", :id => nil)
      book.save()
      book2 = Book.new(:title => "LLamas in Pajamas", :author => "author", :id => nil)
      book2.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end

  describe('#update') do
    it("updates a book by id") do
      book = Book.new({:title => "House of Leaves", :author => "author", :id => nil})
      book.save()
      book.update("Another Roadside Attraction")
      expect(book.title).to(eq("Another Roadside Attraction"))
    end
  end

  describe('#delete') do
  it("deletes all books belonging to a deleted checkout") do
    book = Book.new({:title => "Giant Steps", :author => "author", :id => nil})
    book.save()
    patron = Patron.new({:name => "Mr.Robo", :id => nil})
    patron.save()
    checkout = Checkout.new({:book_id => book.id, :patron_id => patron.id, :id => nil})
    checkout.save()
    book.delete()
    expect(Checkout.find(checkout.id)).to(eq(nil))
    end
  end

end