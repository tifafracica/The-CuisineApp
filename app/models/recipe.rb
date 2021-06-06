class Recipe

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
    info_api = HTTParty.get("https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&number=15&apiKey=#{ENV["API_KEY"]}&query=#{@data}")
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
    info_api = HTTParty.get("https://api.spoonacular.com/recipes/#{@data}/information?fillIngredients=true&apiKey=#{ENV["API_KEY"]}")
    selected_recipe_array = []
    hash = {
      title: info_api["title"],
      image: info_api["image"],
      duration: info_api["readyInMinutes"],
      servings: info_api["servings"],
      ingredients: info_api["extendedIngredients"].blank? ? '' : info_api["extendedIngredients"].map{|rep| rep["original"]},
      steps:  unless info_api["analyzedInstructions"].blank?
                  info_api["analyzedInstructions"].map{|data_steps| data_steps["steps"]}[0].map{|x| x["step"]}.join(" ")
              else
                " "
              end
    }
    selected_recipe_array.push(hash)
    selected_recipe_array
  end

end