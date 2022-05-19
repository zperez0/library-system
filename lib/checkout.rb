class Checkout 
  attr_reader :id
  attr_accessor :book_id, :patron_id #due_date? 

  def initialize(attributes)
    @book_id = attributes.fetch(:books_id)
    @patron_id = attributes.fetch(:patrons_id)
  end

  # def self.all
  #   returned_checkouts = 


  def save
    result = DB.exec("INSERT INTO checkouts (books_id, patrons_id) VALUES ('#{@book_id}', '#{@patron_id}');")
  end

  def self.find(patron_id)
    checkout = DB.exec("SELECT * FROM checkouts WHERE patrons_id = #{patron_id};").first
    if checkout
      patron_id = checkout.fetch("patrons_id").to_i
      book_id = checkout.fetch("books_id").to_i
      Checkout.new({:patrons_id => patron_id, :books_id => book_id, :id => nil})
    else
      nil
    end
  end
end
      



# create ==()


# checkout class needed if more data needs to be stored ex: due date

# create find()