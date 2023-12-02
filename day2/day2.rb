require_relative '../lib/file_reader.rb'

# Running the actual problems

def sanity_check
  raw_data = FileReader.read_lines('./sanity_data')
  validity_string = "12 red cubes, 13 green cubes, and 14 blue cubes"
  games = []
  raw_data.each do |raw_game_string|
    games.append(Game.parse_game_data(raw_game_string))
  end
  game_set = GameSet.new(
    validity_string,
    games
  )
  game_set
    .valid_games
    .map{ |game| game.game_number}
    .flatten
    .map{ |n| n.to_i}
    .sum
end

def problem_1
  raw_data = FileReader.read_lines('./part1_data')
  validity_string = "12 red cubes, 13 green cubes, and 14 blue cubes"
  games = []
  raw_data.each do |raw_game_string|
    games.append(Game.parse_game_data(raw_game_string))
  end
  game_set = GameSet.new(
    validity_string,
    games
  )
  game_set
    .valid_games
    .map{ |game| game.game_number}
    .flatten
    .map{ |n| n.to_i}
    .sum
end

def problem_2
  raw_data = FileReader.read_lines('./part1_data')
  validity_string = "12 red cubes, 13 green cubes, and 14 blue cubes"
  games = []
  raw_data.each do |raw_game_string|
    games.append(Game.parse_game_data(raw_game_string))
  end
  game_set = GameSet.new(
    validity_string,
    games
  )
  game_set
    .games
    .map{ |game| game.min_req_set_power}
    .sum
end

# Utility methods, too lazy to make mixins

# turns "1 red" into ["1", "red"]
def parse_number_color(number_colour)
  number_colour.scan(/(\d+) (\w+)/).flatten
end

# Classes

class GameSet
  attr_accessor :games
  def initialize(validity_string, games)
    @validity_string = validity_string
    @validity_hash = parse_validity_string(validity_string)
    @games = games
  end

  def parse_validity_string(validity_string)
    validity_hash = {}
    clean_vs_entries = validity_string.gsub(" cubes", "").gsub("and ", "").split(",")
    clean_vs_entries.each do |entry|
      number, colour = parse_number_color(entry)
      validity_hash[colour] = number.to_i
    end
    validity_hash
  end

  def valid_games
    @games.select do |game|
      include_game = true
      game.max_colours.each do |colour, max|
        include_game &&= max <= @validity_hash[colour]
      end
      include_game
    end
  end
end

class Game
  attr_accessor :max_colours
  attr_accessor :game_number
  attr_accessor :min_req_set_power

  def initialize(game_number, pulls)
    @game_number = game_number
    @pulls = pulls
    @max_colours = parse_colour_maximums
    @min_req_set_power = minimum_required_set_power()
  end

  def self.parse_game_data(raw_game_string)
    game_number = raw_game_string.scan(/Game (\d*):/)
    pulls = raw_game_string.split(":")[1].strip.split(";").map{|x| x.split(",")}
    self.new(
      game_number,
      pulls
    )
  end

  private

  def parse_colour_maximums
    max_colours = {}
    @pulls.each do |pull|
      pull.each do |subpull_by_colour|
        number, colour = parse_number_color(subpull_by_colour)
        if !max_colours.key?(colour) || max_colours[colour].to_i < number.to_i
          max_colours[colour] = number.to_i
        end
      end
    end
    max_colours
  end

  def minimum_required_set_power
    power = 1
    @max_colours.each do |colour, number|
      power *= number
    end
    power
  end
end

p sanity_check
p problem_1
p problem_2