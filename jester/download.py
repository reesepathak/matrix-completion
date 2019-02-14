from io import BytesIO as BIO
from zipfile import ZipFile as ZF
import pandas as pd
import requests

def link_to_csv(link, fname):
    zf = ZF(BIO((requests.get(link)).content))    
    return pd.read_excel(BIO(zf.read(fname)))

links = ["http://eigentaste.berkeley.edu/dataset/jester_dataset_1_1.zip",
         "http://eigentaste.berkeley.edu/dataset/jester_dataset_1_2.zip"]
files = ["jester-data-1.xls", "jester-data-2.xls"]

for (i, (l, f)) in enumerate(zip(links, files)):
    df = link_to_csv(l, f)
    df.to_csv("data/jester_data_{}.csv".format(i + 1))
    
    
    
