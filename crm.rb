require 'sinatra'
require 'data_mapper'
require_relative 'rolodex'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:database.sqlite3")    #creates a local file called "database.sqlite3" = whole db

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!        #takes care of changes in database structure in between executions


@@rolodex = Rolodex.new         #like a global variable for the lifetime of the app; ignore the warning "class variable access from toplevel"
@@app_name = "HQCRM"
@@company_name = "HQCasanova"

#Main menu
get '/' do 
  erb :index                    
end

#Create a new contact: the GET action for the new contact form
get '/contacts/new' do
  erb :new_contact
end

#Fetches the form for changing a single contact's details
get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

#Single resource for a contact
get '/contacts/:id' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

#List all the contacts
get '/contacts' do
  @contacts = Contact.all(:order => [:first_name.asc])       #select * from contacts sorted by first name
  erb :contacts                 #erb 'contacts/new.rb' if you reflect the structure of the url
end

#Display all emails
get '/emails' do             
  @contacts = Contact.all(:fields=>[:email])
  erb :emails
end

#Handle edit contact form submission (POST request + method argument specifying PUT)
put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    @contact.save               #make changes permanent
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

#Handle delete contact form submission (POST request + method argument specifying DELETE)
delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

#Handle contact creation form submission (POST request)
post '/contacts' do
  puts params
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
  )
  redirect to('/contacts')      #Automatic redirection to all contacts. UX enhancement
end

