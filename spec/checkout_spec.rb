require('spec_helper')

describe('Checkout') do

  describe('.find') do
    it('returns a checkout if checkout exists in database') do
      patron = Patron.new({:name => "Mr.Robo", :id => nil})
      patron.save()
      book = Book.new({:title => "hello world", :author => "author", :id => nil})
      book.save()
      checkout = Checkout.new({:books_id => book.id, :patrons_id => patron.id, :id => nil})
      checkout.save()
      expect(Checkout.find(patron.id)).to(eq(checkout))
    end
  end

  describe('#save') do
    it('returns an empty array when there are no books') do
      patron = Patron.new({:name => "Mr.Robo", :id => nil})
      patron.save()
      book = Book.new({:title => "hello world", :author => "author", :id => nil})
      book.save()
      checkout = Checkout.new({:books_id => book.id, :patrons_id => patron.id, :id => nil})
      checkout.save()
      expect(Checkout.find(patron.id)).to(eq(checkout))
    end
  end
end