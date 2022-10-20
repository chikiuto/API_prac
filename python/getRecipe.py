# %%

from ctypes import resize
import json
from math import fabs
import time
from pprint import pprint
import requests
import pandas as pd

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# 全てのカテゴリーを取得
res = requests.get('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1038863537950891238')
json_data = json.loads(res.text)
# print(json_data)

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

print(category_df)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# キーワードを含む行を抽出
category_df_keyword = category_df.query('categoryName.str.contains("サラダ")', engine='python')
# print(category_df_keyword)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# 人気レシピを取得する
# recipe_columns = ['recipeId', 'recipeTitle', 'foodImageUrl', 'recipeMaterial', 'recipeCost', 'recipeIndication', 'categoryId', 'categoryName']
recipe_columns = ['recipeTitle', 'recipeUrl', 'foodImageUrl', 'recipeMaterial', 'recipeCost', 'recipeIndication' ]
recipe_df = pd.DataFrame(columns=recipe_columns)
category_df_keyword.to_csv('/Users/tokichi/abe_no_folder/medirom_Web/API_prac/python/categoryIds.csv')


for index, row in category_df_keyword.iterrows():
    # 連続でアクセスすると先方のサーバに負荷がかかるので少し待つのがマナー
    time.sleep(1) 
    
    url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1038863537950891238&categoryId='+row['categoryId']
    res = requests.get(url)

    json_data = json.loads(res.text)
    recipes = json_data['result']

    for recipe in recipes:
        list_small = [[ 
                        recipe['recipeTitle'],
                        recipe['recipeUrl'],
                        recipe['foodImageUrl'],
                        recipe['recipeMaterial'],
                        recipe['recipeCost'],
                        recipe['recipeIndication'],
                    ]]
        df_append = pd.DataFrame(data=list_small, columns=recipe_columns)
        df_append["image"] = df_append["foodImageUrl"].map(lambda s: "<img src='{}' height='200' />".format(s))
        df_append["go to recipe"] = df_append["recipeUrl"].map(lambda s: "<a href='{}' > レシピへ</a>".format(s))
        recipe_df = pd.concat([recipe_df, df_append], ignore_index=True, axis=0)

recipe_df.drop(columns='foodImageUrl', inplace=True)
recipe_df.drop(columns='recipeUrl', inplace=True)
recipe_df.duplicated(keep='first', subset='recipeTitle')
recipe_df
# mainData = recipe_df.query('recipeIndication.str.contains("5分以内")', engine='python').sample(n=3).to_html(classes=["table", "table-bordered", "table-hover"], escape=False)
# print(mainData)
# htmlData = open(r"/Users/tokichi/abe_no_folder/medirom_Web/API_prac/app/views/recipes/_result.html.erb","w")
# htmlData.write(mainData)
# htmlData.close()

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 



# %%