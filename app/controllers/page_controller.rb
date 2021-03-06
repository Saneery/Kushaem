require 'will_paginate/array'

class PageController < ApplicationController
	def index
		search = params[:search].mb_chars.downcase.to_s
	    if search!=''
	      if params[:type]=='food'
	  	    @objects = Food.tagged_with(search).sort_by_rating + Food.where(name: search).sort_by_rating
	  	    @objects.uniq!
	  	    @objects.select!{|o| o.publick.approve == true }
	        @objects = @objects.paginate(per_page: 10, page: params[:page])
	        render "foods/index"
	      elsif params[:type]=='publick'
	        @objects = Publick.where(name: search).sort_by_rating
	        @objects.select!{|o| o.approve == true}
	        @objects = @objects.paginate(per_page: 10, page: params[:page])
	        render "publicks/index"
	      end
	    else 
	      if params[:type]=='food'
	      	@objects = Food.all.sort_by_rating
	        @objects.select!{|o| o.publick.approve == true}
	        @objects = @objects.paginate(per_page: 10, page: params[:page])
	        render "foods/index"

	      elsif params[:type]=='publick'
	        @objects = Publick.all.sort_by_rating
	        @objects.select!{|o| o.approve == true}
	        @objects = @objects.paginate(per_page: 10, page: params[:page])
	        render "publicks/index"
	      end
	    end
	end

	def about
    end
    def info
    end
end
