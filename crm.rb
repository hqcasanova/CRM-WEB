require 'sinatra'
require_relative 'contact'      #the _relative makes sure it works relative to local folder
require_relative 'rolodex'

@@rolodex = Rolodex.new         #like a global variable for the lifetime of the app; ignore the warning "class variable access from toplevel"
@@app_name = "HQCRM"
@@company_name = "HQCasanova"
@@index = false

#Main menu
get '/' do 
  @@index = true
  erb :index                    
end

#List all the contacts
get '/contacts' do
  erb :contacts                 #erb 'contacts/new.rb' if you reflect the structure of the url
end

#Display an attribute
get '/attribute' do             #at the moment, shows all emails
  erb :attribute
end

#Create a new contact: the GET action for the new contact form
get '/contacts/new' do
  erb :new_contact
end

#Process data from contact creation form: the POST action for the contact form
post '/contacts' do
  puts params
  @@rolodex.add_contact(params['first_name'], params['last_name'], params['email'], params['note'])
  redirect to('/contacts')      #Automatic redirection to all contacts. UX enhancement
end

