class Recipe
  require_relative '../../.api_key.rb'

  def initialize(data)
    require 'httparty'
    require 'json'
    @data = data
  end

  def perform
    endpoint
    recipe_endpoint
  end

  def endpoint
    info_api = HTTParty.get("https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&number=15&apiKey=#{$api_key}&query=#{@data}")
    recipes_array = []
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

  def recipe_endpoint
    info_api = HTTParty.get("https://api.spoonacular.com/recipes/complexSearch?fillIngredients=true&addRecipeInformation=true&apiKey=#{$api_key}&query=")
    recipe = info_api["results"].select{|x| x["id"] == @data }
    selected_recipe_array = []
    recipe.map {|item|
      hash = {
        title: item["title"],
        image: item["image"],
        duration: item["readyInMinutes"],
        servings: item["servings"],
        ingredients: item["extendedIngredients"].map{|rep| rep["original"]},
        steps: item["analyzedInstructions"].map{|data_steps| data_steps["steps"]}[0].map{|x| x["step"]}.join(" ")
      }
      selected_recipe_array.push(hash)
    }
    selected_recipe_array
  end

end