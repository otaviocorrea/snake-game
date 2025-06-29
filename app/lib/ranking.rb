

module Ranking
  RANK_FILE = '.rank'

  def load_ranking
    @ranking = $gtk.read_file(RANK_FILE)
                   .to_s.lines.map do |line|
      name, score = line.chomp.split(' - ')
      { name: name, score: score.to_i }
    end
  rescue StandardError
    @ranking = []
  end

  def save_ranking
    @ranking << { name: @player_name, score: @score }
    @ranking = @ranking.sort_by { |r| -r[:score] }.first(10) # Keep top 10
    $gtk.write_file(RANK_FILE, @ranking.map { |r| "#{r[:name]} - #{r[:score]}" }.join("\n"))
  end
end

