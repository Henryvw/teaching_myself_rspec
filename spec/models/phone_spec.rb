require 'rails_helper'

describe Phone do
  it "does not allow duplicate phone numbers inside of the same contact" do
    contact = Contact.new(
      firstname: 'David',
      lastname: 'Francis',
      email: 'tester@example.com')
    phone_number = Phone.new(
      contact_id: contact.id ,
      phone: '5556661234',
      phone_type: 'home')
    phone_number.save
    phone_number2 = Phone.new(
      contact_id: contact.id ,
      phone: '5556661234',
      phone_type: 'home')
    expect(phone_number2).to be_invalid
  end
  it "allows the same phone number to be saved inside different contacts" do
    contact1 = Contact.new(
      firstname: 'David',
      lastname: 'Francis',
      email: 'david@example.com'
      )
    contact2 = Contact.new(
      firstname: 'Kelly',
      lastname: 'Lapman',
      email: 'kelly@example.com'
      )
    contact1.save
    contact2.save
    phone_number1 = Phone.new(
      contact_id: contact1.id ,
      phone: '5556661234',
      phone_type: 'home')
    phone_number1.save
    phone_number2 = Phone.new(
      contact_id: contact2.id ,
      phone: '5556661234',
      phone_type: 'home')
    expect(phone_number2).to be_valid
  end
end


#interesting to note that both of these tests test the same
#line in the Model - "validates :phone, uniqueness: { scope: :contact_id }".
#I think a lesson about RSpec testing is to write the tests from a slightly higher level
#of value. Don't just write the bare bones, but really think about the true value of
#functionality that the program should be having for an end user / product owner.
