require "open-uri"

class PagesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @user_word = params[:user_word]
    @check_word = english_word(@user_word) # calling method bellow
    @included = @user_word.chars.all? { |char| @letters.include?(char) }
    # chars turn into array, .all returns true for all elements into array
    # block checks each char is included in array. If yes, the .all will be True
  end

  def english_word(user_word)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{user_word}")
    # returns json
    json = JSON.parse(url.read)
    # transforms json response to ruby array of hashes
    json['found']
    # extracts value of hash and indicates if {"found":true} is T of F
  end
end
