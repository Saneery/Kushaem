class ComplaintsController < ApplicationController
	def new
		if current_user
			publick = Publick.find(params[:publick_id])
		  	@complaint = publick.complaints.new
		  end
	end

	def create
		if simple_captcha_valid?
			publick = Publick.find(params[:publick_id])
			@complaint = publick.complaints.new(complaint_params)
			@complaint.user_id = current_user.id
			@complaint.save
			render :show
	    end
    end

    def show
    end

    private
	def complaint_params
		params.require(:complaint).permit(:message)
	end
end
