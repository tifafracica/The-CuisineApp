class RecipesController < ApplicationController

  def index
    @search = ''
    response = Recipe.new(@search)
    @results = response.endpoint
  end

end
