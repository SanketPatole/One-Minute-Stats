import numpy as np
import pandas as pd
import urllib.request
import math
import os

def download_flags():
    flagfilepath = os.path.dirname(os.getcwd())
    flag_filename = "map_flag.csv"
    df_flags = pd.read_csv(flagfilepath + "\\" + flag_filename)
    for url in df_flags["Flag"]:
        print(url)
        headers = {
            'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
            'Accept-Encoding': 'none',
            'Accept-Language': 'en-US,en;q=0.8',
            'Connection': 'keep-alive',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'}
        request = urllib.request.Request(url=url, headers=headers)
        response = urllib.request.urlopen(request)
        f = open(flagfilepath + '//flags//' + url.split("/")[-3] + ".png", 'wb')
        f.write(response.read())
        f.close()

filename = "datafile.csv"
filepath = os.getcwd()
df_values = pd.read_csv(filepath+"\\"+filename, encoding='latin1', index_col=0)
for col in df_values:
    df_values[col] = pd.to_numeric(df_values[col], errors='coerce')
df_values = df_values.groupby(df_values.index).sum()
df_ranks = df_values.drop(columns=df_values.columns)
length_of_video_in_seconds = 1*60
frames_per_second = 30
frame_rate = frames_per_second*length_of_video_in_seconds//(len(df_values.columns)-1)

#download_flags()

for col in df_values.columns:
    s = pd.DataFrame(df_values[col].sort_values(ascending=False))
    s[col] = np.arange(len(df_values))
    df_ranks = df_ranks.join(s)

df_values = df_values.transpose()
df_ranks = df_ranks.transpose()

df_values.index = pd.to_datetime(df_values.index)
df_ranks.index = pd.to_datetime(df_ranks.index)

total_num_periods = (len(df_values) - 1) * frame_rate + 1
date_range_obj = pd.date_range(start=df_values.index[0], end=df_values.index[-1], periods=total_num_periods)
df_values = df_values.reindex(date_range_obj).interpolate()
df_ranks = df_ranks.reindex(date_range_obj).interpolate()

df_values.to_csv(filepath+"\\values.csv")
df_ranks.to_csv(filepath+"\\ranks.csv")