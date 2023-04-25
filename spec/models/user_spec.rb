require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(first_name: 'Test', last_name: 'User', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    end

    it 'should save successfully with all required fields set' do
      expect(@user.save).to be true
    end

    it 'should not save without a password' do
      @user.password = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save without a password confirmation' do
      @user.password_confirmation = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not save with a password and password confirmation that do not match' do
      @user.password_confirmation = 'wrongpassword'
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not save with a non-unique email' do
      @user.save
      new_user = User.new(first_name: 'Test', last_name: 'User', email: 'TEST@test.com', password: 'password', password_confirmation: 'password')
      expect(new_user.save).to be false
      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require an email' do
      @user.email = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should require a first name' do
      @user.first_name = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should require a last name' do
      @user.last_name = nil
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(first_name: 'Test', last_name: 'User', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    end

    it 'should return an instance of user if successfully authenticated' do
      expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq @user
    end

    it 'should return nil if authentication is unsuccessful' do
      expect(User.authenticate_with_credentials('test@test.com', 'wrongpassword')).to be nil
    end

    it 'should ignore leading and trailing spaces in the email' do
      expect(User.authenticate_with_credentials('  test@test.com  ', 'password')).to eq @user
    end

    it 'should ignore case sensitivity in the email' do
      expect(User.authenticate_with_credentials('TeSt@TeSt.CoM', 'password')).to eq @user
    end
  end
end
