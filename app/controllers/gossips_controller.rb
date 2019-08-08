class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:show, :new, :create]
  before_action :only_user, only: [:edit, :update, :destroy]

	def index
		@gossips = Gossip.all
	end

	def show
    @gossip = Gossip.find(params[:id])
  end

  def new # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  	@gossip = Gossip.new
  end

  def create
  	@gossip = Gossip.new(title: params[:title],content: params[:content],user: current_user)
    if @gossip.save
    	puts 'la sauvegarde a fonctionné'
    	flash[:success] = "Votre gossip à bien été enregistré !"
    	redirect_to gossips_path
  	else
    	puts 'la sauvegarde n a pas fonctionné'
  		render 'new'
    end	
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    post_params = params.require(:gossip).permit(:title, :content)
    if @gossip.update(post_params)
      puts 'modif prise en compte'
      redirect_to gossips_path
    else
      puts 'modif non prise en compte'
      render 'edit'
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
  end

  private

    def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
      end
    end

  
    def only_user
      @gossip = Gossip.find(params[:id])
    unless current_user == @gossip.user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
      end
    end

end