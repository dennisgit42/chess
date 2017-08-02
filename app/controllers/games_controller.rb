class GamesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show update]

  def index
    @available_games = Game.available
  end

  def new; end

  def create
    @game = Game.new(game_params)
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.user_black.nil?
      @game.update(user_black_id: current_user.id)
    else
      @game.update(user_white_id: current_user.id)
    end
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:user_white_id, :user_black_id)
  end
end
