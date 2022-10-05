class RecipesController < ApplicationController
  def index
    @recipe = `/Library/Developer/CommandLineTools/usr/bin/python3 /Users/tokichi/abe_no_folder/medirom_Web/API_prac/python/getRecipe.py`
    @hoge = 'hoge'
  end
end
