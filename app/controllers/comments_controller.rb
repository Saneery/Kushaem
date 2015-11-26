class CommentsController < ApplicationController
	
	def create
    if simple_captcha_valid?
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
        redirect_to food_path @commentable
      else
      	redirect_to publick_path @commentable
      end
    else
      flash[:notice] = 'Не правильно введен код с картинки'
       if params[:food_id]
        redirect_to food_path params[:food_id]
      else
        redirect_to publick_path params[:publick_id]
      end
    end
	end
	
	private
	def comment_params
		params.require(:comment).permit(:content)
	end
	
end
