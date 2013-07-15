class GamesController < ApplicationController
  def index
    @game = Game.new
    @games = Game.highscores
  end
  
  def show
    @game = Game.find(params[:id])
    @shots = @game.shots
  end
  
  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game
    else
      render :index
    end
  end
  
  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to root_path
    else
      render :show
    end
  end
end
