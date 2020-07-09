require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Mauz J',
             email: 'mauz@mail.xyz',
             password: '123456')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid if new user does not have a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if new user does not have an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end
