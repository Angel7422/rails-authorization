class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all
    authorize @restaurants
  end

  # GET /restaurants/1
  def show
    authorize @restaurant
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      redirect_to @restaurant, notice: "Restaurant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: "Restaurant was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy!
    redirect_to restaurants_url, notice: "Restaurant was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
      authorize @restaurant
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
