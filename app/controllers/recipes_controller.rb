require 'net/http'
require 'uri'
require 'json'


class RecipesController < ApplicationController
  def index
    # @recipes = `/Library/Developer/CommandLineTools/usr/bin/python3 /Users/tokichi/abe_no_folder/medirom_Web/API_prac/python/getRecipe.py`
    # @categories = RakutenWebService::Recipe.small_categories

    # @category_ids = []
    # @categories.each do |category|
    #   if category.name.include?("サラダ")
    #     @category_ids.push(category.id)
    #   end
    # end

    @category_ids = [ "18-415", "18-424", "18-421", "18-189",
                     "18-187", "18-417", "18-416", "18-419",
                     "18-420", "18-423", "18-190", "18-703",
                     "18-184", "18-188", "18-185", "18-186",
                     "18-191", "42-556", "50-655",
                     "10-69-2133", "16-152-911", "16-156-1345",
                     "18-184-946", "18-184-949", "18-184-950",
                     "18-184-1412", "18-184-2163", "18-184-945",
                     "18-184-947", "18-184-943", "18-184-1408",
                     "18-184-1409", "18-184-948", "18-184-1410",
                     "18-184-1411", "18-185-951", "18-186-952",
                     "18-187-796", "18-188-953", "18-188-954",
                     "18-188-955", "18-188-956", "18-188-957",
                     "18-188-958", "18-189-797", "18-190-959",
                     "18-191-794", "20-197-2012", "26-262-1077",
                     "18-415-1395", "18-416-1396", "18-417-1397",
                     "18-419-1399", "18-420-1400", "18-421-1401",
                     "18-423-1403", "18-424-1404", "42-556-1786",
                     "50-655-1916", "18-703-2003"
                    ]

    uri = URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1038863537950891238');
    json = Net::HTTP.get(uri);

    hash = JSON.parse(json);
    @result = hash["result"];

    
  end
end
