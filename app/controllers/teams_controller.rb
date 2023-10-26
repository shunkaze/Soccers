class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @search = Team.ransack(params[:q])
    @teams = @search.result
    @user = current_user
    @team = @user.teams.new(team_params)
    @teams = Team.all
    if @team.save
      flash[:notice] = 'You have created team successfully.'
      redirect_to team_path(@team.id)
    else
      render :new
    end
  end

  def index
    @search = Team.ransack(params[:q])
    @teams = @search.result
    @team = Team.new
    @user = current_user
  end

  def edit
    @team = Team.find(params[:id])
    if @team.user != current_user
      redirect_to teams_path
    end
  end

  def show
    @search = Team.ransack(params[:q])
    @teams = @search.result
    @team = Team.find(params[:id])
    @user = @team.user
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:notice] = 'You have updated team successfully.'
      redirect_to team_path(@team.id)
    else
      render :edit
    end
  end

  def destroy
    team = Team.find(params[:id])
    team.destroy
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:title, :body)
  end
end
