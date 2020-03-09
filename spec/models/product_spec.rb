require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context "working?" do

      it "should create a new instance" do
        cat_Params = {
          id: 5, 
          name: "Cool",
        }
        user_Params = {
          name: "Nick",
          price: 10,
          quantity: 15,
          category_id: cat_Params[:id]
        }
        @category = Category.new(cat_Params)
        @product = Product.new(user_Params)
        expect(@product[:name]).to eq("Nick")

      end
    end

    context "Presence?" do
      before(:all) do
        cat_params = {
          id: 5,
          name: "Cool",
        }
        @category = Category.new(cat_params)
      end 

      it "should pass the test without a name validation" do
        user_params = {
          price: 11,
          quantity: 16,
          category_id: @category.id
        }
        @product =  Product.new(user_params)

        @product.validate
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it "should pass the test without a price validation" do
        user_params = {
          name: "Nick",
          quantity: 12,
          category_id: @category.id
        }
        @product = Product.new(user_params)
        @product.validate
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it "should pass the test without a quantity validation" do
        user_params = {
          name: "Nick",
          price: 13,
          category_id: @category.id
        }
        @product = Product.new(user_params)
        @product.validate
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end

      it "should pass the test without a category  validation" do
        user_params = {
          name: "Nick",
          price: 14,
          quantity: 17,
        }
        @product = Product.new(user_params)
        @product.validate
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end



  end

end

  # validates :name, presence: true
  # validates :price, presence: true
  # validates :quantity, presence: true
  # validates :category, presence: true

#1 - Test -> should create a new Object
#2 - Test a validation
#3 -