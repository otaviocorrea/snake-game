
module GameState
  def tick_name_input
    @player_name += @args.inputs.text.join("") if @args.inputs.text

    if @args.inputs.keyboard.key_down.backspace
      @player_name.chop!
    end

    if @args.inputs.keyboard.key_down.enter && !@player_name.empty?
      reset
    end
    draw_name_input
  end

  def tick_playing
    handle_input
    update
    draw_background
    draw_walls
    draw_game
  end

  def tick_game_over
    if @args.inputs.keyboard.key_down.r
      @game_state = :name_input
      @player_name = ""
    end
    draw_game_over
  end
end
