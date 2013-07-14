class GamesController < ApplicationController
  def index
    @game = Game.new
    @games = Game.highscores
  end
  
  def show
    @game = Game.find(params[:id])
    @shots = @game.shots
    @shot = @game.shots.build
  end
  
  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game
    else
      render :index
    end
  end
end
