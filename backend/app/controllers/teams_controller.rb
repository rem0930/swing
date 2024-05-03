class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy]

  # GET /teams
  def index
    @teams = Team.all
    render json: @teams
  end

  # GET /teams/:id
  def show
    render json: @team
  end

  # POST /teams
  def create
    @team = @current_user.teams.new(team_params)

    if @team.save
      render json: @team, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/:id
  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/:id
  def destroy
    @team.destroy
  end

  private

  def set_team
    @team = @current_user.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :details, :profile_photo, :background_photo)
  end
end