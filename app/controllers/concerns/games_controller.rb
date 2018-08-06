require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @game = params[:game]
    @score = 0

    url = 'https://wagon-dictionary.herokuapp.com/' + @game
    response_serialized = open(url).read
    response = JSON.parse(response_serialized)

    game_letter = @game.upcase.split("")
    game_letter.each do |item|
      if !@letters.include?(item)
        @message = "Sorry but #{@game} can't be build out of #{@letters}"
      elsif response["found"]
        @message = "Congratulations, #{@game} is valid English word"
        @score += @game.length.to_i
      else
        @message = "Sorry but #{@game} does not seem to be a valid English word..."
      end
    end
  end
end
