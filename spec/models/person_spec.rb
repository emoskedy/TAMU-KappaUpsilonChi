require 'rails_helper'

RSpec.describe Person, type: :model do
  it 'is valid with all attributes filled out' do
    person = Person.create(
      name: 'John Doe',
      email: 'john@example.com',
      address: '123 Main St',
      uin: '123456789',
      phone_number: '555-1234',
      affiliation: 'Student'
    )
    expect(person).to be_valid
  end

  it 'is valid with some attributes filled out' do
    person = Person.create(
      name: 'John Doe',
      email: 'john@example.com',
      address: '',
      uin: '123456789',
      phone_number: '555-1234',
      affiliation: ''
    )
    expect(person).to be_valid
  end
end
