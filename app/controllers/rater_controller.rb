
require 'will_paginate/array'

class RaterController < ApplicationController

	def index
  	if params[:section] == 'likes_food'
  		rate = Rate.where(rateable_type: "Food", rater_id: current_user.id).select(:rateable_id)
  		@objects = Food.where(id: rate).sort_by_rating
        @objects = @objects.paginate(per_page: 10, page: params[:page])
        render "foods/index"
    else 
    	rate = Rate.where(rateable_type: "Publick", rater_id: current_user.id).select(:rateable_id)
    	@objects = Publick.where(id: rate).sort_by_rating
        @objects = @objects.paginate(per_page: 10, page: params[:page])
        render "publicks/index"
    end
end

  def create
    if current_user
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]

      render :json => true
    else
      render :json => false
    end
  end

  
end
