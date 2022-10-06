class RecipesController < ApplicationController
  def index
    @recipe = system('/Library/Developer/CommandLineTools/usr/bin/python3 /Users/tokichi/abe_no_folder/medirom_Web/API_prac/python/getRecipe.py')
    @recipe_ = `/Library/Developer/CommandLineTools/usr/bin/python3 /Users/tokichi/abe_no_folder/medirom_Web/API_prac/python/getRecipe.py`
    @hoge = 'hoge'
  end
end
