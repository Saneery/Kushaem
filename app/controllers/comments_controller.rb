class CommentsController < ApplicationController
	
	def create
      if params[:food_id]
      	@commentable = Food.find(params[:food_id])
      else
      	@commentable = Publick.find(params[:publick_id])
      end
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        @commentable.comments << @comment
      end
      if params[:food_id]
        redirect_to "/publicks/#{params[:publick_id]}/food/#{params[:food_id]}"
      else
      	redirect_to publick_path @commentable
      end
	end
	
	private
	def comment_params
		params.require(:comment).permit(:content)
	end
	
end
