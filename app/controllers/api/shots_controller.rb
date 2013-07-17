class Api::ShotsController < ApplicationController
  respond_to :json
  
  def index
    respond_with Shot.all
  end
  
  def show
    respond_with Shot.find(params[:id])
  end
  
  def create
    @game = Game.find(params[:game_id])
    x, y = @game.defend
    server_pos = [x,y]
    player_pos = [1,2]
    player_pos = [params[:shot][:x_pos], params[:shot][:y_pos]]
    @shot = @game.check_if_goal(server_pos, player_pos)
    respond_with :api, @shot
  end
  
end
