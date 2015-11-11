
class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
  	unless @user
  		redirect_to login_url
  	end
  end

  def create
  	unless exist?(user_params[:email]) 
  	  if user_params[:password] == user_params[:password_confirmation]
  	    @user = User.new(user_params)
  	    @user.role = "user"
  	    if @user.save
  	  	  session[:user_id] = @user.id
  	  	  redirect_to '/'
  	    else
  	  	  redirect_to signup_url
  	    end
  	  else
  	  	flash[:notice] = 'Пароли не совпали'
  	  	redirect_to signup_url
  	  end
  	else
  	  flash[:notice] = 'Пользователь с такой эл-почтой уже существует'
  	  redirect_to signup_url
    end
  end

  private 
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  def exist?(mail)
  	User.find_by(email: mail)
  end
end
