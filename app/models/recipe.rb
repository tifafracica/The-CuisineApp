class Recipe
  require_relative '../../.api_key.rb'

  def initialize(data)
    require 'httparty'
    require 'json'
    @search = data
  end

  def perform
    endpoint
  end

  def endpoint
    info = HTTParty.get("https://api.spoonacular.com/recipes/complexSearch?number=15&apiKey=#{$api_key}&query=#{@search}&addRecipeNutrition=true")
  end

end