class RestaurantsController < ApplicationController
	before_action :authenticate_owner!, only: [:new, :create, :edit, :update, :destroy]
	before_filter :check_owner, only: [:edit, :update, :destroy]

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
		@restaurant.owner_id = current_owner.id

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

		def check_owner
			@restaurant = Restaurant.find(params[:id])
			if current_owner != @restaurant.owner
				redirect_to root_url
			end	
		end
end