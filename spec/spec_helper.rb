require 'rspec'
require 'pg'
require 'book'
require 'patron'
require 'checkout'
require 'pry'

# shared code for clearing tests between runs & connecting to the DB:

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM checkouts *;")
  end
end