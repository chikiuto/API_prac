class CreateController < ApplicationController
  def index
    @test = params[:recipe_id]
    @recipe = Recipe.find(params[:recipe_id])
  end
end
