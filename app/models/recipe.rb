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
    info_api = HTTParty.get("https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&number=15&apiKey=#{$api_key}&query=#{@search}")
    recipes_array =[]
    info_api["results"].map{ |recipe|
      hash = {
        id: recipe["id"],
        title: recipe["title"],
        duration: recipe["readyInMinutes"],
        servings: recipe["servings"],
        image: recipe["image"]
      }
      recipes_array.push(hash)
    }
    recipes_array
  end

end