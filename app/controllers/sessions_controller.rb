class SessionsController < ApplicationController

  def new
  end

  def create
  user = User.find_by(email: params[:email])
  puts user
  	if user && user.authenticate(params[:password])
  		puts 'le login a marché'
    	session[:user_id] = user.id
    	redirect_to gossips_path
  	else
  		puts 'le login n a pas marché'
    	flash.now[:danger] = 'Invalid email/password combination'
    	render 'new'
  	end
	end

  def destroy
  	session.delete(:user_id)
  	puts 'le loug-out a marché'
  	redirect_to gossips_path
	end

end