require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    # raise
    @word = params[:word]
    if !in_grid
      @result = "Sorry, but #{@word.upcase} can't be built out of #{@letters}"
    elsif !english_word
      @result = "Sorry, but #{@word.upcase} does not seem to be an English word"
    elsif !english_word && in_grid
      @result = "Sorry, but #{@word.upcase} does not seem to be an English word"
    else in_grid && english_word
      @result = "Congratulations! #{@word.upcase} is an English word"
    end
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.opne(url).read
    parsed_result = JSON.parse(word_serialized)
    return parsed_result['found']
  end

  def in_grid
    @word.chars.all? do |letter|
      @word.count(letter) == 10
    end
  end

end
