require 'rails_helper'

describe Contact do
  it "saves/creates data validly if the data arrives as firstname, lastname, and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end
  it "blocks save/create data as invalid if the data lacks a firstname" do
    contact = Contact.new(
      lastname: 'Sumner',
      email: 'tester@example.com')
    expect(contact).to be_invalid
  end
  it "blocks save/create data as invalid if the data lacks a lastname" do
    contact = Contact.new(
      firstname: 'Aaron',
      email: 'test@wxample.com')
    expect(contact).to be_invalid
  end
    it "blocks save/create data as invalid if the data lacks an email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner')
    expect(contact).to be_invalid
  end
  it "blocks save/create data as invalid if the data has a non-unique email address" do
    contact1 = Contact.new(
      firstname: 'David',
      lastname: 'Francis',
      email: 'tester@example.com')
    contact1.save
    contact2 = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com')
    contact2.save
    expect(contact2.errors[:email]).to include("has already been taken")
  end
  it "includes a method to return a first name and last name as a single string" do
    contact = Contact.new(
      firstname: 'David',
      lastname: 'Francis',
      email: 'tester@example.com')
    binding.pry
    expect(contact.name).to include("David Francis")
  end
end
