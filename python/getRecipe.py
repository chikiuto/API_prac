# %%

import json
from math import fabs
import time
from pprint import pprint
import requests
import pandas as pd

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# 全てのカテゴリーを取得
def getCategory():
    res = requests.get('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1038863537950891238')
    json_data = json.loads(res.text)

    category_columns = ['category1','category2','category3','categoryId','categoryName']
    category_df = pd.DataFrame(columns=category_columns)

    # 大カテゴリ
    for category in json_data['result']['large']:
        list_large = [[category['categoryId'],
                                "",
                                "",
                                category['categoryId'],
                                category['categoryName']
                    ]]
        df_append = pd.DataFrame(data=list_large, columns=category_columns)
        category_df = pd.concat([category_df, df_append], ignore_index=True, axis=0)

    # 中カテゴリ
    parent_dict = {} # mediumカテゴリの親カテゴリの辞書
    for category in json_data['result']['medium']:
        list_medium = [[category['parentCategoryId'],
                        category['categoryId'],
                        "",
                        str(category['parentCategoryId'])+"-"+str(category['categoryId']),
                        category['categoryName']
                    ]]
        df_append = pd.DataFrame(data=list_medium, columns=category_columns)
        category_df = pd.concat([category_df, df_append], ignore_index=True, axis=0)
        parent_dict[str(category['categoryId'])] = category['parentCategoryId']

    # 小カテゴリ
    for category in json_data['result']['small']:
        list_small = [[ parent_dict[category['parentCategoryId']],
                        category['parentCategoryId'],
                        category['categoryId'],
                        parent_dict[category['parentCategoryId']]+"-"+str(category['parentCategoryId'])+"-"+str(category['categoryId']),
                        category['categoryName']
                ]]
        df_append = pd.DataFrame(data=list_small, columns=category_columns)
        category_df = pd.concat([category_df, df_append], ignore_index=True, axis=0)

    return category_df

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# キーワードを含む行を抽出
def getSalad(DataFrame):
    category_df_keyword = DataFrame.query('categoryName.str.contains("サラダ")', engine='python')
    return category_df_keyword

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# 人気レシピを取得する
def getRecipe(DataFrame):
    recipe_columns = ['recipeId', 'recipeTitle', 'foodImageUrl', 'recipeMaterial', 'recipeCost', 'recipeIndication', 'categoryId', 'categoryName']
    recipe_df = pd.DataFrame(columns=recipe_columns)



    for index, row in DataFrame.iterrows():
        time.sleep(1) # 連続でアクセスすると先方のサーバに負荷がかかるので少し待つのがマナー
        
        url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1038863537950891238&categoryId='+row['categoryId']
        res = requests.get(url)

        json_data = json.loads(res.text)
        recipes = json_data['result']


        for recipe in recipes:
            list_small = [[ recipe['recipeId'],
                            recipe['recipeTitle'],
                            recipe['foodImageUrl'],
                            recipe['recipeMaterial'],
                            recipe['recipeCost'],
                            recipe['recipeIndication'],
                            row['categoryId'],
                            row['categoryName']
                    ]]
            df_append = pd.DataFrame(data=list_small, columns=recipe_columns)
            recipe_df = pd.concat([recipe_df, df_append], ignore_index=True, axis=0)

    return recipe_df.query('recipeIndication.str.contains("5分以内")', engine='python')

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


def main():
    DataFrame = getCategory()
    saladData = getSalad(DataFrame)
    saladLecipe = getRecipe(saladData)
    return saladLecipe.to_html

if __name__ == '__main__':
    main()
# %%