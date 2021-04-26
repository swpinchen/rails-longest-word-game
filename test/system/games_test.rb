require "application_system_test_case"
include RSpec::Matchers

class GamesTest < ApplicationSystemTestCase
  VOWELS = %w(A E I O U)
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert test: 'New game'
    assert_selector 'li', count: 10
  end

  test 'fill the form with a random word and click play, gives us a message that the word is not in the grid' do
    visit new_url
    fill_in 'word', with: 'abcdefghij'
    click_on 'Play'
    assert test: 'Fill random word not in dictonary'
    expect(page).to have_content "can't be built out of"
  end

  test 'You can fill the form with one letter, click play and get a message that not a valid word' do
    visit new_url
    fill_in 'word', with: Array.new(1) { (('A'..'Z').to_a - VOWELS).sample }.join # excludes all vowels
    click_on 'Play'
    assert test: "Fill single letter that [can't be build out of] or [is not a valid word]"
    expect(page).to have_content 'Sorry' # Applies for both can't be built out of and not a valid word
  end

  # test 'You can fill the form with a valid English word, click play and get a “Congratulations” message.' do
  #   visit new_url
  #   fill_in 'word', with: 'i'
  #   click_on 'Play'
  #   assert test: 'Fill single letter is a valid word' # difficult because of randomness
  #   expect(page).to have_content 'Congratulations'
  # end
end
