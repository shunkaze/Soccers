class UsersController < ApplicationController
  def index
    @search = Player.ransack(params[:q])
    @players = @search.result
    @search = Team.ransack(params[:q])
    @teams = @search.result
    @user = current_user
    @users = User.all
  end

  def show
    @search = Player.ransack(params[:q])
    @players = @search.result
    @search = Team.ransack(params[:q])
    @teams = @search.result
    @user = User.find(params[:id])
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
