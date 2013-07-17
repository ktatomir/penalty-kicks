require 'net/http'
require 'json'

class ApiTest
  attr_accessor :oryginal_body, :status
  attr_reader :parsed_json
  
  def initialize(body=nil, status_code=nil)
    self.oryginal_body = body
    self.status = status_code
  end
  
  def parsed_json
    JSON.parse(self.oryginal_body)
  end
  
  def show_highscored_games
    res = ApiTest.get_request('/api/games', [])
    self.oryginal_body = res.body
    self.status = res.code
    self
  end
  
  def show_game(game_id)
    res = ApiTest.get_request('/api/games/'+game_id.to_s, [])
    self.oryginal_body = res.body
    self.status = res.code
    self
  end
  
  def show_shot(game_id, shot_id)
    res = ApiTest.get_request('/api/games/'+game_id.to_s+'/shots/'+shot_id.to_s, [])
    self.oryginal_body = res.body
    self.status = res.code
    self
  end
  
  def new_game(player_name=nil)
    res = ApiTest.post_request('/api/games', {'game[player_name]' => player_name})
    self.oryginal_body = res.body
    self.status = res.code
    self
  end
  
  def new_shot(game_id, x_pos=nil, y_pos=nil)
    url = '/api/games/'+ game_id.to_s + '/shots.json'
    res = ApiTest.post_request(url, {"shot[game_id]"=> game_id, "shot[x_pos]" => x_pos, "shot[y_pos]" => y_pos})
    self.oryginal_body = res.body
    self.status = res.code
    self
  end
  
  @@http = nil
  class << self
    def http_instance
      return @@http if @http
      uri = URI('http://0.0.0.0:3000')
      @@http = Net::HTTP.new(uri.host, uri.port)
    end
    
    def get_request(path, data)
      req = Net::HTTP::Get.new(path)
      req.set_form_data(data)
      self.http_instance.request(req)
    end
    
    def post_request(path, data)
      req = Net::HTTP::Post.new(path)
      req.set_form_data(data)
      self.http_instance.request(req)
    end
    
  end     
end



api = ApiTest.new
puts "Enter your name"
name = gets.chomp
game = api.new_game(name).parsed_json
puts "Created game #{game}"
i = 0
while i <=4 do
  puts "Enter where to shot in format ZxY, eg: 1x2\n
  Min: 1x1, max: 4x4"
  position = gets.chomp.split("x")
  shot = api.new_shot(game['id'], position[0], position[1])
  shot_body, status = shot.parsed_json, shot.status
  if status == "422"
    puts shot_body
  else
    puts shot_body["score"] == 1 ? "GOAL!" : "Sorry, defended."
    i += 1
  end
end
game = api.show_game(game["id"]).parsed_json[0]
puts game['scores']