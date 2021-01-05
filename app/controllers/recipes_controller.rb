class RecipesController < ApplicationController

  def index
    @search = params[:search]
    response = Recipe.new(@search)
    @results = response.endpoint
  end

  def show
    recipe_id = params[:id]
    find_the_recipe = Recipe.new(recipe_id.to_i)
    @results = find_the_recipe.recipe_endpoint
  end

end
