class RestaurantsController < ApplicationController
	before_action :authenticate_owner!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@restaurants = Restaurant.all
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		@restaurant.owner_id = current_owner.id

		if @restaurant.save 
			flash[:notice] = "Restaurant #{@restaurant.name} successfully Created"
		redirect_to @restaurant
		else
			render :new
		end
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
	end

	def update
		@restaurant = Restaurant.find(params[:id])

		if @restaurant.update(restaurant_params)
			redirect_to @restaurant
		else
			render :edit
		end
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy
		redirect_to restaurants_path
	end

	private
		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :full_address, :phone_number)
		end

end