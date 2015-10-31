class FoodController < ApplicationController
  
  def index
  	@food = Food.all 
  end

  def new
  	@food = Food.new
  end

  def create
  	@food = Food.create(food_params)
    @food.tag_list.add(params[:ingredients].split(',').each{|w| w.downcase!})
    @food.save
  end

  private
  def food_params
  	params.require(:food).permit(:image, :name, :description, :shop_id, :price)
  end
  
end
