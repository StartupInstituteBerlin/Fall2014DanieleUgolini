require 'rails_helper'
	
describe RestaurantsController, :type => :controller do

	before(:each) do
		@owner = FactoryGirl.create(:owner)
		@restaurant =FactoryGirl.create(:restaurant)
	end
	
	describe "GET #index" do
		it "Returns list of Restaurants" do
			get :index
			expect(response).to be_success
			expect(assigns(:restaurants)).to eq(Restaurant.all)
		end
	end

	#describe "GET #edit" do
	#	context "When Not Logged In" do
	#		it "Redirects to index page" do
	#			@request.env["devise.mapping"] = Devise.mappings[:owner]
	#			get(:edit, {:id=>@restaurant})
	#		end
	#	end
	#end

	describe 'GET #edit' do
		before do
			@request.env["devise.mapping"] = Devise.mappings[:owner]
		end
		
		context 'When Not Logged In' do
			it 'Redirects to Login In page' do
				get(:edit, {:id=>@restaurant})
				expect(response).to redirect_to(new_owner_session_path)
			end
		end

		context 'When Logged in' do

			context 'Restaurant owner' do
				it 'edit' do
					sign_in @restaurant.owner
					get(:edit, {:id=>@restaurant})
					expect(response).to be_success
				end
			end

			context 'Not the restaurant owner' do
				it 'Redirects to error' do
					sign_in @owner
					get(:edit, {:id=>@restaurant})
					expect(response).to redirect_to(root_path)
				end
			end
		end
	end

	describe 'GET #update' do
		before do
			@request.env["devise.mapping"] = Devise.mappings[:owner]
		end
		
		context 'When Not Logged In' do
			it 'Redirects to Login In page' do
				get(:update, {:id=>@restaurant})
				expect(response).to redirect_to(new_owner_session_path)
			end
		end

		context 'When Logged in' do

			context 'Restaurant owner' do
				it 'redirects to restaurant page' do
					sign_in @restaurant.owner
					post(:update, {:id=>@restaurant, :restaurant=>{:name=>"The New Name"}})
					expect(response).to redirect_to(@restaurant)
				end

				it "Stores the updated name" do
					sign_in @restaurant.owner
					post(:update, {:id=>@restaurant, :restaurant=>{:name=>"The New Name"}})
					@restaurant.reload
					expect(@restaurant.name).to eq("The New Name")
				end
			end

			context 'Not the restaurant owner' do
				it 'Redirects to root_path' do
					sign_in @owner
					get(:update, {:id=>@restaurant})
					expect(response).to redirect_to(root_path)
				end
			end
		end
	end

end

