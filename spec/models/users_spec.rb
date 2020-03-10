require 'rails_helper'

RSpec.describe User, type: :model do

  describe "password confirmations" do
    

    context "password validation" do

      it "shouldn't succeed considering both passwords are the different" do
        
        passing = {
          name: "Nick",
          email: "ndanvers222@gmail.com",
          password: "123456",
          password_confirmation: "23456",
        }

       @user =  User.new(passing)
       @user.validate
       expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "Shouldn't succeed when a duplicate email is used" do
        passing = {
          name: "Nick",
          email: "ndanvers222@gmail.com",
          password: "123456",
          password_confirmation: "123456",

        }
        @user1 = User.new(passing)
        @user1.save

        failing = {
          name: "Nick",
          email: "ndanvers222@gmail.com",
          password: "123456",
          password_confirmation: "1123456",
        }
        @user2 = User.new(failing)
        @user2.save
        @user2.validate
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
      describe "Authentication " do
        passing = {
          name: "Nick",
          email: "     ndanvers222@gmail.com",
          password: "123456",
          password_confirmation: "123456",

        }
        it "Should authenticate with credentials" do
          @user = User.new(passing)
          @user.save
          expect(User.authenticate_with_credentials(@user.email, @user.password)).to_not be_nil
        end

        it "Should be null" do
          failing = {
            name: "Nick",
            email: "ndanvers222@gmail.com",
            password: "123456",
            password_confirmation: "1123456",
          }
          @user = User.new(failing)
          @user.save
          expect(User.authenticate_with_credentials(@user.email, @user.password)).to be_nil
          
        end

      end


    end
  end

end


