class ReservationsController < ApplicationController
  #before_action :load_restaurant, :except => [:index, :show, :edit]
  before_action :authenticate_owner!, only: [:destroy]


	def index
		@restaurant = Restaurant.find(params[:restaurant_id])
		@reservations = @restaurant.reservations
  end

	def create
    @restaurant = Restaurant.find(params[:restaurant_id])
		@reservation = @restaurant.reservations.build(reservations_params)
    if @reservation.save
      redirect_to root_path, notice: "Booked table at #{@restaurant.name}"
    else
      render :new
    end
  end

	def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.find(params[:id])

    if @reservation.update(reservations_params)
      redirect_to restaurant_reservation_path(@restaurant, @reservation)
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to @restaurant
  end

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.find(params[:id])
  end

	private

  #def load_restaurant
  #  @restaurant = Restaurant.find(params[:restaurant_id])
  #end

  def reservations_params
    params.require(:reservation).permit(:email, :request_time, :message, :status)
  end

end
