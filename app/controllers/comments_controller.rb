class CommentsController < ApplicationController
	
	def create
      @commentable = find_commentable
      @comment = @commentable.comments.new(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      redirect_to @commentable

	end
	private
	def comment_params
		params.require(:comment).permit(:content)
	end
	def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
