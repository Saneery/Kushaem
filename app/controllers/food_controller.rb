class FoodController < ApplicationController
  before_action :require_editor, only: [:new, :edit, :update, :create]
  def index
    search = params[:search]
    if search!=nil&&search!=''
      if params[:type]=='tag'
  	    @foods = Food.tagged_with(search.downcase).paginate(per_page: 10, page: params[:page])
      elsif params[:type]=='name'
        @foods = Food.where(name: search.downcase).paginate(per_page: 10, page: params[:page])
      end
    else 
      @foods = Food.paginate(per_page: 10, page: params[:page])
    end
  end

  def new
  	publick = Publick.find(params[:publick_id])
    @food = publick.foods.new
    
  end

  def create
    publick = Publick.find(params[:publick_id])
    if current_user.id == publick.user_id
      @food = publick.foods.create(food_params)
      @food.tag_list.add(params[:ingredients].split(',').each{|w| w.downcase!})
      @food.save
    end
    redirect_to publick
  end

  def show
    @food = Food.find(params[:id])
    @comment = @food.comments.new
    @comments = @food.comments.all
  end
  def mainpage
  end

  private
  def food_params
  	params.require(:food).permit(:image, :name, :description, :publick_id, :price)
  end
  
end
