require 'rails_helper'
	
describe User do
	describe "#owner?" do
		it "return true if role is owner" do
			@daniele = FactoryGirl.build(:user)
			@daniele.role = "owner"
			expect(@daniele.owner?).to eq(true)
		end

		it "return false for all other roles" do
			@user = FactoryGirl.build(:user)
			@user.role = "XXX"
			expect(@user.owner?).to be false
		end

		it "has patron as a default role" do
		@user = FactoryGirl.build(:user)
		expect(@user.role).to eq("patron")	
		end


    it "raises an error if role value is invalid"
	end

	describe "patron?" do
	end

	describe "Validations" do
		it "validates with role owner" do
			@user = FactoryGirl.build(:user)
			@user.role = "owner"
			expect(@user.valid?).to eq(true)
		end
		
		it "validates with role patron" do
			@user = FactoryGirl.build(:user)
			@user.role = "patron"
			expect(@user.valid?).to be true
		end

		it "does not validate if role is something else" do
			@user = FactoryGirl.build(:user)
			@user.role = "XXX" 
			expect(@user.valid?).to be false
		end
	end
end
			