##########Represents one contact: a bunch of personal details together with a unique ID
class Contact
  attr_accessor :id, :first_name, :last_name, :email, :notes

  def initialize(id, first_name, last_name, email, notes)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @notes = notes
  end

  def to_s
    "ID: #{@id}\n" +
    "First name: #{@first_name}\n" +
    "Last name: #{@last_name}\n" +
    "E-mail: #{@email}\n" +
    "Notes: #{@notes}\n"
  end
end