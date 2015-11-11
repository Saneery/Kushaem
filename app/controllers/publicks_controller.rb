class PublicksController < ApplicationController
	before_action :require_editor, only: [:new, :edit, :update, :create]

	def index
		@publicks = Publick.where(approve: true)
	end
	
	def new
		@publick = Publick.new
	end

	def create
		@publick = Publick.new(publick_params)
		@publick.approve = false
		if @publick.save
			current_user.publicks << @publick
			redirect_to publicks_path
		end
	end

	def show
		@publick = Publick.find(params[:id])
		@comments = @publick.comments.all
		@comment = @publick.comments.new
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def publick_params
    	params.require(:publick).permit(:name, :description, :address)
    end


end
