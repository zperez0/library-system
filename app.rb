require('pg')
require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/checkout')
require('./lib/patron')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @books = Books.all 
  erb(:books)
end

get('/books') do
  @books = Books.all
  erb(:books)
end

get('/books/new') do
  erb(:new_book)
end

get('/books/:id') do
  @book = Book.find(params[:id].to_i())
  erb(:books)
end

post('/books') do
  title = params[:book_title]
  book = Book.new(:title => title, :id => nil)
  book.save()
  @books = Book.all()
  erb(:books)
end

get('/books/:id/edit') do
  @book = Book.find(params[:id].to_i())
  erb(:edit_book)
end

patch('/books/:id') do
  @book = Book.find(params[:id].to_i())
  @book.update(params[:title])
  @books = Book.all
  erb(:books)
end

delete('/books/:id') do
  @book = Book.find(params[:id].to_i())
  @book.delete()
  @books = Book.all
  erb(:books)
end

