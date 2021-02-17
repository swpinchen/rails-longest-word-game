class GamesController < ApplicationController
  # display a new random grid and a form.
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  # The form will be submitted (with POST) to the score action.
  def score
    params[:word].split('').each do |letter|
      @letters = params[:letters].split
      @word = (params[:word] || "").upcase
      @included = included?(@word, @letters)
    end
  end
end
