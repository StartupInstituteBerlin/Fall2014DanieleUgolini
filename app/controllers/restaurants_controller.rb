class RestaurantsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_filter :check_user, only: [:edit, :update, :destroy]

	def index
		@restaurants = Restaurant.all
	end

	def show
		@restaurant = Restaurant.find(params[:id])
    @reservation = Reservation.new
    @reservation.restaurant = @restaurant
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		@restaurant.user_id = current_user.id

		if @restaurant.save 
			flash[:notice] = "Restaurant #{@restaurant.name} successfully Created"
		redirect_to @restaurant
		else
			render :new
		end
	end

	def edit
		3.times { @restaurant.reservations.build }
	end

	def update
		
		if @restaurant.update(restaurant_params)
			redirect_to @restaurant
		else
			render :edit
		end
	end

	def destroy
		@restaurant.destroy
		redirect_to restaurants_path
	end

	private
		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :full_address, :phone_number, 
				reservations_attributes:[:id, :status])

		end

		def check_user
			@restaurant = Restaurant.find(params[:id])
			if current_user != @restaurant.user
				redirect_to root_url
			end	
		end
end