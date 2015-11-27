class PublicksController < ApplicationController
	before_action :require_editor, only: [:new, :edit, :update, :create]

	def index
		@objects = Publick.where(approve: true).paginate(per_page: 10, page: params[:page])
	end
	
	def new
		@publick = Publick.new
	end
    

	def create
		@publick = Publick.new(publick_params)
		@publick.approve = false
		@publick.message = 'Заведение проверяется администраторами'
		if @publick.save
			current_user.publicks << @publick
			redirect_to user_path @publick.user
		else 
			render :new
		end
	end

	def show
		@publick = Publick.find_by_id(params[:id]) or redirect_to root_path
		if @publick
			if @publick.user_id!=session[:user_id] && !@publick.approve
        		redirect_to root_path
        	end
			@comments = @publick.comments.all
			@comment = @publick.comments.new
		end
	end

	def edit
    	@publick = Publick.find_by_id(params[:id])
    	unless @publick.user_id = current_user.id
    		redirect_to @publick
    	end
    end

	def update
    	@publick = Publick.find params[:id]
    	@publick.approve = false
		@publick.message = 'Заведение проверяется администраторами'
		if @publick.save
			current_user.publicks << @publick
			redirect_to user_path @publick.user
		else 
			render :edit
		end
    end

	def destroy
	end

	private
	def publick_params
    	params.require(:publick).permit(:name, :description, :address, :city, :avatar)
    end


end
