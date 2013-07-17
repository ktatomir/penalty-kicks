class Api::GamesController < ApplicationController
  respond_to :json
  
  def index
    respond_with Game.highscores
  end
  
  def show
    @game = Game.find(params[:id])
    respond_with [@game, @game.shots]
  end
  
  def create
    respond_with Game.create(params[:game])
  end
  
  def update
    respond_with Game.update(params[:game])
  end
  
  def destroy
    respond_with Game.destroy(params[:id])
  end
end
