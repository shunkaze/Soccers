class PlayersController < ApplicationController
  def new
    @search = Player.ransack(params[:q])
    @players = @search.result
    @player = Player.new
  end
  
  def create
    @search = Player.ransack(params[:q])
    @players = @search.result
    @user = current_user
    @player = @user.players.new(player_params)
    @players = Player.all
    if @player.save
      flash[:notice] = 'You have created player successfully.'
      redirect_to player_path(@player.id)
    else
      render :new
    end
  end
  
  def index
    @search = Player.ransack(params[:q])
    @players = @search.result
    @player = Player.new
    @user = current_user
  end
  
  def edit
    @player = Player.find(params[:id])
    if @player.user != current_user
      redirect_to players_path
    end
  end
  
  def show
    @search = Player.ransack(params[:q])
    @players = @search.result
    @player = Player.find(params[:id])
    @user = @player.user
  end
  
  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      flash[:notice] = 'You have updated player successfully.'
      redirect_to player_path(@player.id)
    else
      render :edit
    end
  end
  
  def destroy
    player = Player.find(params[:id])
    player.destroy
    redirect_to players_path
  end
  
  private
  
  def player_params
    params.require(:player).permit(:title, :body)
  end
end
