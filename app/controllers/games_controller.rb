require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    @score = calculate_score(@included, @english_word, @word).to_s
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    if word.length > 1
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      json['found']
    elsif word.include?('I') || word.include?('A')
      true
    else
      false
    end
  end

  def calculate_score(included, english_word, word)
    if included && english_word then word.length
    else 0
    end
  end
end
