
module GameSetup
  def initialize(args)
    @args = args
    @grid_size = 20
    @screen_width = args.grid.w / @grid_size
    @screen_height = args.grid.h / @grid_size
    @game_state = :name_input
    @player_name = ""
    @base_speed = 10
    @speed_increase_interval = 5 # points needed to increase speed
    @frame_counter = 0
    setup_walls
    load_ranking
  end

  def setup_walls
    @walls = []
    gap_size = 5 # The size of the gap in the walls

    # Horizontal walls (top and bottom)
    (0...@screen_width).each do |x|
      # Create a gap in the middle
      next if x.between?((@screen_width / 2) - gap_size, (@screen_width / 2) + gap_size)
      @walls << { x: x, y: 0 }
      @walls << { x: x, y: @screen_height - 1 }
    end

    # Vertical walls (left and right)
    (1...@screen_height - 1).each do |y| # Use 1...-1 to avoid drawing over corners
      # Create a gap in the middle
      next if y.between?((@screen_height / 2) - gap_size, (@screen_height / 2) + gap_size)
      @walls << { x: 0, y: y }
      @walls << { x: @screen_width - 1, y: y }
    end
  end

  def reset
    @snake = [{ x: (@screen_width / 2).to_i, y: (@screen_height / 2).to_i }]
    @direction = :right
    @next_direction = :right
    @food = new_food
    @score = 0
    @game_over = false
    @game_state = :playing
    @update_interval = @base_speed
  end
end
