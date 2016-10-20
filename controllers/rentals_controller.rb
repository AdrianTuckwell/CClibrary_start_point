require 'pry-byebug'
require_relative('../models/rental')
require_relative('../models/book')
require_relative('../models/member')

#index -------------------------------------------------------------
get '/rentals' do
  @rentals = Rental.all()
  erb :'rentals/index'
end

#new ---------------------------------------------------------------
get '/rentals/new' do
  @books = Book.all()
  @members = Member.all()
  erb :'rentals/new'

end

#create -------------------------------------------------------------
post '/rentals' do
  # Sinatra from a form will return a ‘params’ hash (it just does),
  # which can be accessed hash element or as a :symbol
  @rental = Rental.new(params)
  @rental.save
  erb :'rentals/create'
end
