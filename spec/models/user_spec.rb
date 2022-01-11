require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    subject do
      User.new(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )
    end

    it 'should create a user given valid conditions' do
      expect(subject).to be_valid
    end

    it 'should error if a name is not given' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should error if an email is not given' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'should error if a password is shorter than 4 characters' do
      subject.password = "lig"
      expect(subject).to_not be_valid
    end

    it 'should error if the password does not match the password_confirmation' do
      subject.password_confirmation = "lighthouselab"
      expect(subject).to_not be_valid
    end
    
    it 'should error upon creation of a user with an email that already exists in the database' do
      @user1 = User.create(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )

      @user2 = User.create(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )

      expect(@user2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate a valid user' do
      @user = User.create(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )

      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it 'should not authenticate an incorrect email' do
      @user = User.create(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )

      expect(User.authenticate_with_credentials("email", @user.password)).to eq(nil)
    end

    it 'should not authenticate an incorrect password' do
      @user = User.create(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )

      expect(User.authenticate_with_credentials(@user.email, "password")).to eq(nil)
    end

    it 'should authenticate a valid user regardless of text-case of email' do
      @user = User.create(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )

      expect(User.authenticate_with_credentials("trentPF@hotmail.com", @user.password)).to eq(@user)
    end

    it 'should authenticate a valid user regardless of leading and trailing empty space on email field' do
      @user = User.create(
        name: "Trent Pfeiffer",
        email: "trentpf@hotmail.com",
        password: "lighthouselabs",
        password_confirmation: "lighthouselabs"
      )

      expect(User.authenticate_with_credentials("   trentpf@hotmail.com   ", @user.password)).to eq(@user)
    end
  end
end
