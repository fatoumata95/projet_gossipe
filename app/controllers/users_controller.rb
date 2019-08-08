class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
 	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(first_name: params[:first_name],last_name: params[:last_name],email: params[:email], password: params[:password])
  	if @user.save
  		puts 'l inscription a fonctionné'
  		session[:user_id] = user.id
  		redirect_to gossips_path
  	else
  		puts 'l inscription n a pas fonctionné'
  		render 'new'
  	end	
  end

  def edit
  end

  def update
  end

  def destroy
  end

end