class RecipesController < ApplicationController

  def index
    @search = params[:search]
    response = Recipe.new(@search)
    @results = response.endpoint
  end

end
