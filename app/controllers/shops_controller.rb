class ShopsController < ApplicationController
	before_action :require_editor, only: [:new, :edit, :update, :create]

	def index
		@shops = Shop.all
	end
	def new
		@shop = Shop.new
	end

	def create
		@shop = Shop.new(shop_params)
		if @shop.save
			current_user.shops << @shop
			redirect_to '/'
		else
			redirect_to
		end
	end

	def show
		@shop = Shop.find(params[:id])
		@food = Food.new
		
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def shop_params
    	params.require(:shop).permit(:name, :description, :address)
    end


end
