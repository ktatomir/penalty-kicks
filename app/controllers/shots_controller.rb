class ShotsController < ApplicationController
  def create
    @game = Game.find(params[:shot][:game_id])
    x, y = @game.defend
    server_pos = [x,y]
    player_pos = [params[:shot][:x_pos], params[:shot][:y_pos]]
    shot = @game.check_if_goal(server_pos, player_pos)
    if !shot.id.nil?
      @shots = @game.shots
      respond_to do |format|
        format.html { redirect_to @game }
        format.js
      end
    else
      flash[:error] = "Kick failed."
      redirect_to @game
    end
  end
end
