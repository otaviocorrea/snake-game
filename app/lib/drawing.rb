
module Drawing
  def draw_background
    @args.outputs.solids << { x: 0, y: 0, w: @args.grid.w, h: @args.grid.h, r: 0, g: 191, b: 255 } # Cyan Blue
  end

  def draw_walls
    @walls.each do |wall|
      @args.outputs.solids << { x: wall[:x] * @grid_size, y: wall[:y] * @grid_size, w: @grid_size, h: @grid_size, r: 100, g: 100, b: 100 } # Gray walls
    end
  end

  def draw_game
    @snake.each do |segment|
      @args.outputs.solids << { x: segment[:x] * @grid_size, y: segment[:y] * @grid_size, w: @grid_size, h: @grid_size, r: 0, g: 0, b: 0 } # Black snake
    end

    @args.outputs.solids << { x: @food[:x] * @grid_size, y: @food[:y] * @grid_size, w: @grid_size, h: @grid_size, r: 255, g: 0, b: 0 }
    @args.outputs.labels << { x: 20, y: @args.grid.h - 20, text: "Score: #{@score}", r: 255, g: 255, b: 255 }
  end

  def draw_name_input
    draw_background
    @args.outputs.labels << { x: @args.grid.w / 2, y: @args.grid.h / 2 + 50, text: "Enter your name:", size_enum: 5, alignment_enum: 1, r: 255, g: 255, b: 255 }
    @args.outputs.labels << { x: @args.grid.w / 2, y: @args.grid.h / 2, text: @player_name, size_enum: 5, alignment_enum: 1, r: 255, g: 255, b: 255 }
    @args.outputs.labels << { x: @args.grid.w / 2, y: @args.grid.h / 2 - 50, text: "Press Enter to start", size_enum: 2, alignment_enum: 1, r: 255, g: 255, b: 255 }
  end

  def draw_game_over
    draw_background
    @args.outputs.labels << { x: @args.grid.w / 2, y: @args.grid.h / 2 + 100, text: "Game Over!", size_enum: 10, alignment_enum: 1, r: 255, g: 255, b: 255 }
    @args.outputs.labels << { x: @args.grid.w / 2, y: @args.grid.h / 2 + 50, text: "Your score: #{@score}", size_enum: 5, alignment_enum: 1, r: 255, g: 255, b: 255 }
    @args.outputs.labels << { x: @args.grid.w / 2, y: @args.grid.h / 2, text: "Press R to restart", size_enum: 2, alignment_enum: 1, r: 255, g: 255, b: 255 }

    @args.outputs.labels << { x: 50, y: @args.grid.h - 50, text: "Ranking:", size_enum: 4, r: 255, g: 255, b: 255 }
    @ranking.each_with_index do |r, i|
      @args.outputs.labels << { x: 50, y: @args.grid.h - 80 - (i * 30), text: "#{i + 1}. #{r[:name]} - #{r[:score]}", r: 255, g: 255, b: 255 }
    end
  end
end
