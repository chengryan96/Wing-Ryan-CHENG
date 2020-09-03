#improt packages
import pandas as pd
import requests
import talib


#list of stocks in the index


#sp-500
US_index_list = ['dowjones', 'nasdaq100', 'sp500']
# Use request to obtain the data

def US_stock_list(index):
    url = 'https://www.slickcharts.com/'+str(index)
    headers = {"User-Agent" : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'}
    #get info
    request = requests.get(url, headers = headers)
    data = pd.read_html(request.text)[0]
    #get symbol
    stk_list = data.Symbol
    stk_list = data.Symbol.apply(lambda x: x.replace('.', '-'))
    return stk_list

DOW_list = US_stock_list('dowjones')
NASDAQ_list = US_stock_list('nasdaq100')
SP500 = US_stock_list('sp500')

#noted pytickersymbols is also an option

#get hk stock list
def HK_stock_list():
    return pd.read_csv(r'C:\Users\admin\Desktop\stock_above_MA_checker\csv\hk_stock_list.csv')['HSI'].tolist()
