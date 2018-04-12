import pandas as pd


data = pd.read_csv('theme_1_small_areas.csv', encoding='ISO-8859-1')

data.columns = data.columns.str.replace('\s+', '')
print(data.columns)
df_sum = data.groupby('County')[["Total_Population_2011", "Male_Population_2011","Female_Population_2011","Age_Band_0_14_2011","Age_Band_15_24_2011","Age_Band_25_44_2011","Age_Band_45_64_2011","Age_Band_65plus_2011" ,"Total_Single_2011","Total_Married_2011" ,"Total_Separated_2011","Total_Divorced_2011","Total_Widowed_2011"]].sum()
#print(df_sum)

df_mean = data.groupby('County')[["Perc_Male_Population_2011","Perc_Female_Population_2011","Perc_Age_Band_0_14_2011","Perc_Age_Band_15_24_2011","Perc_Age_Band_25_44_2011"	,"Perc_Age_Band_45_64_2011"	,"Perc_Age_Band_65plus_2011","Perc_Single_2011","Perc_Married_2011",	"Perc_Separated_2011","Perc_Divorced_2011","Perc_Widowed_2011"]].mean()
df_mean = df_mean.round(2)
#print(df_mean)

concat_df = pd.concat([df_sum, df_mean], axis=1)
# Removing the Limerick County, Waterford County
concat_df = concat_df.drop(['Limerick County', 'Waterford County'])

concat_df = concat_df.rename({'Dún Laoghaire-Rathdown': 'Dun_Laoghaire_Rathdown', \
        "Cork City" : "Cork_City", "Cork County": "Cork_County", "Dublin City" : "Dublin_City", \
        "Galway City": "Galway_City", "Galway County" : "Galway_County", "Limerick City" : "Limerick", \
        "South Dublin" : "South_Dublin", "Waterford City" : "Waterford", "Laoighis" : "Laois" \
        })
#print(concat_df)

concat_df.to_csv("data_vis.csv")
