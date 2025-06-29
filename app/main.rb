require 'app/lib/game_setup.rb'
require 'app/lib/ranking.rb'
require 'app/lib/game_logic.rb'
require 'app/lib/drawing.rb'
require 'app/lib/game_state.rb'

class SnakeGame
  include GameSetup
  include Ranking
  include GameLogic
  include Drawing
  include GameState

  def tick
    @args.outputs.background_color = [0, 191, 255]
    case @game_state
    when :name_input
      tick_name_input
    when :playing
      tick_playing
    when :game_over
      tick_game_over
    end
  end
end

def tick(args)
  $gtk.set_window_title "Snake Game"
  $game ||= SnakeGame.new(args)
  $game.tick
end