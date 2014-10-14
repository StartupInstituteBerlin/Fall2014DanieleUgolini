class RestaurantsController < ApplicationController
	before_action  :set_restaurant, only: [:show, :edit, :update, :destroy]

	def index
		@restaurants = Restaurant.all
	end

	def show
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		if @restaurant.save
			redirect_to root_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @restaurant.update(restaurant_params)
			redirect_to root_path
		else
			render :edit
		end
	end

	def destroy
		@restaurant.destroy
	end

	private
		def set_restaurant
			@restaurant = Restaurant.find(params[:id])
		end
		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :full_address, :phone_number)
		end
	
end