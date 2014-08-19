##########Container for all contacts. Contacts are considered distinctive if their emails are different.
#Thus, there may be multiple contact entries for a given individual since they have several emails.
#Notice thought that the use of a unique index allows the storage of multiple contacts with exactly the
#same attributes (except, naturally, for the index itself)  
class Rolodex
  def initialize
    @contacts = []
    @index = 1000
  end

  #Creates a new contact, adds it to the array, updates the current index
  #Returns the new contact
  def add_contact(first_name, last_name, email, notes)
    @contacts << Contact.new(@index, first_name, last_name, email, notes)
    @index += 1
    @contacts[-1]
  end

  def is_empty?
    return @index == 1000
  end

  def length
    return @contacts.length
  end

  #Searches for a certain contact according to email (assumed to be unique)
  #Returns the corresponding contact or false if not found
  def search_contact(email)
    @contacts.each do |contact|
      if contact.email == email
        return contact 
      end  
    end
    return false 
  end

  #Modifies the attribute, identified by 'attr_code', of a certain contact selected by email
  #Returns the modified contact object unless an error occurred, in which case false is returned instead.
  def modify(contact, attr_code, new_value)
    case attr_code
    when 0
      contact.first_name = new_value
    when 1
      contact.last_name = new_value
    when 2
      contact.email = new_value
    when 3
      contact.notes = new_value
    else
      contact = false
    end  
    return contact
  end

  #Displays all the contact's attributes followed by carriage return (for convenience, if part of a list)
  def display_particular(contact)
    puts "#{contact}\n"
  end

  #Traverses the data storage structure, displaying all of its items
  def display_all_contacts
    @contacts.each do |contact|
      display_particular(contact) 
    end
  end

  #Display the value of a given attribute for all contacts
  def display_info_by_attribute(attr_code)
    @contacts.each do |contact|
      case attr_code
        when 0
          puts "#{contact.first_name}\n"
        when 1
          puts "#{contact.last_name}\n"
        when 2
          puts "#{contact.email}\n"
        when 3
          puts "#{contact.notes}\n"
      end 
    end
  end

  #Deletes a given contact. Returns it afterwards.
  def delete(contact)
    @contacts.delete(contact)
    return contact
  end  
end