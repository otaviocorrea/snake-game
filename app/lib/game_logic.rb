
module GameLogic
  def handle_input
    if @args.inputs.keyboard.key_down.up && @direction != :down
      @next_direction = :up
    elsif @args.inputs.keyboard.key_down.down && @direction != :up
      @next_direction = :down
    elsif @args.inputs.keyboard.key_down.left && @direction != :right
      @next_direction = :left
    elsif @args.inputs.keyboard.key_down.right && @direction != :left
      @next_direction = :right
    end
  end

  def update
    return if @game_over

    @frame_counter += 1
    return if @frame_counter % @update_interval != 0

    @direction = @next_direction

    head = @snake.first.dup
    case @direction
    when :up then head[:y] += 1
    when :down then head[:y] -= 1
    when :left then head[:x] -= 1
    when :right then head[:x] += 1
    end

    # Screen Wrapping
    if head[:x] < 0
      head[:x] = @screen_width - 1
    elsif head[:x] >= @screen_width
      head[:x] = 0
    end

    if head[:y] < 0
      head[:y] = @screen_height - 1
    elsif head[:y] >= @screen_height
      head[:y] = 0
    end

    # Wall and self collision
    if @walls.include?(head) || @snake.include?(head)
      @game_over = true
      @game_state = :game_over
      save_ranking
      return
    end

    @snake.unshift(head)

    if head == @food
      @score += 1
      @food = new_food
      if @score % @speed_increase_interval == 0 && @update_interval > 2
        @update_interval -= 1
      end
    else
      @snake.pop
    end
  end

  def new_food
    loop do
      food_candidate = { x: rand(@screen_width).to_i, y: rand(@screen_height).to_i }
      # Ensure food doesn't spawn on a wall or the snake
      return food_candidate unless @walls.include?(food_candidate) || @snake.include?(food_candidate)
    end
  end
end
