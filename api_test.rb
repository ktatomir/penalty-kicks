require 'net/http'
require 'json'

class ApiTest
  attr_accessor :oryginal_body, :status
  attr_reader :parsed_json
  
  def initialize(body, status_code)
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
  
  def new_game(player_name=nil)
    res = ApiTest.post_request('/api/games', {'game[player_name]' => player_name})
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