
class FoodsController < ApplicationController

  before_action :require_editor, only: [:new, :edit, :update, :create]
  def index
    publick = Publick.find(params[:publick_id])
    @objects = publick.foods.paginate(per_page: 10, page: params[:page])
  end

  def new
  	publick = Publick.find(params[:publick_id])
    @food = publick.foods.new
    
  end

  def create
    publick = Publick.find(params[:publick_id])
    if current_user.id == publick.user_id
      @food = publick.foods.new(food_params)
      @food.tag_list.add(params[:ingredients].split(',').each{|w| w.downcase!})

      @food.save!
    end
    redirect_to publick
  end

  def show
    @food = Food.find(params[:id])
    @comment = @food.comments.new
    @comments = @food.comments.all
  end

  def edit
    @food = Food.find params[:id]
  end

  def update
    @food = Food.find params[:id]
    if current_user.id == @food.publick.user_id
      @food.tag_list = ""
      @food.tag_list.add(params[:ingredients].split(',').each{|w| w.downcase!})
      @food.update(food_params)

      @food.save!
    end
    redirect_to @food.publick
  end

  def destroy
    food = Food.find(params[:id])
    publick = food.publick
    food.delete
    redirect_to publick
  end

  private
  def food_params
  	params.require(:food).permit(:image, :name, :description, :publick_id, :price)
  end
  
end
