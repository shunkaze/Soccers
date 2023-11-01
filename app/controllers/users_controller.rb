class UsersController < ApplicationController
  def index
    @search_player = Player.ransack(params[:q])
    @search_team = Team.ransack
    @players = @search_player.result
    @search_team = Team.ransack(params[:q])
    @search_player = Player.ransack
    @teams = @search_team.result
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @search_player = Player.ransack(params[:q])
    @search_team = Team.ransack
    @players = @search_player.result
    @search_team = Team.ransack(params[:q])
    @search_player = Player.ransack
    @teams = @search_team.result
    @players = @user.players.all
    @teams = @user.teams.all
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
