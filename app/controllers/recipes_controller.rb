class RecipesController < ApplicationController
  def index
    @recipes = `/Library/Developer/CommandLineTools/usr/bin/python3 /Users/tokichi/abe_no_folder/medirom_Web/API_prac/python/getRecipe.py`
  end
end
