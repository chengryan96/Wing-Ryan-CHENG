import numpy as np
import pandas as pd
import talib
import yfinance as yf
import os
import numpy as np

#input the path of your source file in order to run it
os.chdir(r'C:\Users\admin\Desktop\stock_above_MA_checker\src')
from get_all_stock_list import US_stock_list, HK_stock_list

#get index list
DOW_list = US_stock_list('dowjones')
NASDAQ_list = US_stock_list('nasdaq100')
SP500_list = US_stock_list('sp500')
HSI_list = HK_stock_list()


def close_price_df(index_list, period):
    MA_df = pd.DataFrame()
    for stock in index_list:
        try:
            # valid periods: 1d,5d,1mo,3mo,6mo,1y,2y,5y,10y,ytd,max
            cl_price = yf.Ticker(stock).history(period = period)['Close']
            MA_df = pd.concat([MA_df, cl_price], axis = 1)
        except:
            pass
    MA_df.columns = index_list
    return MA_df

def get_compared_df():
    #DOW compare with MA
    DOW_stock_df = close_price_df(DOW_list, period='2y')
    
    DOW_MA20 = DOW_stock_df.apply(lambda x: talib.MA(x, timeperiod=20), axis = 0)
    DOW_MA50 = DOW_stock_df.apply(lambda x: talib.MA(x, timeperiod=50), axis = 0)
    DOW_MA200 = DOW_stock_df.apply(lambda x: talib.MA(x, timeperiod=200), axis = 0)
    
    compare_DOW_MA20 = pd.DataFrame(np.where(DOW_stock_df > DOW_MA20, 1, 0), index = DOW_stock_df.index)
    compare_DOW_MA20 = compare_DOW_MA20.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_DOW_MA50 = pd.DataFrame(np.where(DOW_stock_df > DOW_MA50, 1, 0), index = DOW_stock_df.index)
    compare_DOW_MA50 = compare_DOW_MA50.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_DOW_MA200 = pd.DataFrame(np.where(DOW_stock_df > DOW_MA200, 1, 0), index = DOW_stock_df.index)
    compare_DOW_MA200 = compare_DOW_MA200.apply(lambda x:sum(x)/len(x), axis = 1)
    
    print('downloaded DOW')
    #NASDAQ compare with MA
    NASDAQ_stock_df = close_price_df(NASDAQ_list, period='2y')
    
    NASDAQ_MA20 = NASDAQ_stock_df.apply(lambda x: talib.MA(x, timeperiod=20), axis = 0)
    NASDAQ_MA50 = NASDAQ_stock_df.apply(lambda x: talib.MA(x, timeperiod=50), axis = 0)
    NASDAQ_MA200 = NASDAQ_stock_df.apply(lambda x: talib.MA(x, timeperiod=200), axis = 0)
    
    compare_NASDAQ_MA20 = pd.DataFrame(np.where(NASDAQ_stock_df > NASDAQ_MA20, 1, 0), index = NASDAQ_stock_df.index)
    compare_NASDAQ_MA20 = compare_NASDAQ_MA20.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_NASDAQ_MA50 = pd.DataFrame(np.where(NASDAQ_stock_df > NASDAQ_MA50, 1, 0), index = NASDAQ_stock_df.index)
    compare_NASDAQ_MA50 = compare_NASDAQ_MA50.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_NASDAQ_MA200 = pd.DataFrame(np.where(NASDAQ_stock_df > NASDAQ_MA200, 1, 0), index = NASDAQ_stock_df.index)
    compare_NASDAQ_MA200 = compare_NASDAQ_MA200.apply(lambda x:sum(x)/len(x), axis = 1)
    
    print('downloaded NASDAQ')
    #SPX compare with MA
    SPX_stock_df = close_price_df(SP500_list, period='1y') #only work with one year
    
    SPX_MA20 = SPX_stock_df.apply(lambda x: talib.MA(x, timeperiod=20), axis = 0)
    SPX_MA50 = SPX_stock_df.apply(lambda x: talib.MA(x, timeperiod=50), axis = 0)
    SPX_MA200 = SPX_stock_df.apply(lambda x: talib.MA(x, timeperiod=200), axis = 0)
    
    compare_SPX_MA20 = pd.DataFrame(np.where(SPX_stock_df > SPX_MA20, 1, 0), index = SPX_stock_df.index)
    compare_SPX_MA20 = compare_SPX_MA20.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_SPX_MA50 = pd.DataFrame(np.where(SPX_stock_df > SPX_MA50, 1, 0), index = SPX_stock_df.index)
    compare_SPX_MA50 = compare_SPX_MA50.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_SPX_MA200 = pd.DataFrame(np.where(SPX_stock_df > SPX_MA200, 1, 0), index = SPX_stock_df.index)
    compare_SPX_MA200 = compare_SPX_MA200.apply(lambda x:sum(x)/len(x), axis = 1)
    
    print('downloaded SPX')
    #HSI compare with MA
    HSI_stock_df = close_price_df(HSI_list, period='2y') #only work with one year
    
    HSI_MA20 = HSI_stock_df.apply(lambda x: talib.MA(x, timeperiod=20), axis = 0)
    HSI_MA50 = HSI_stock_df.apply(lambda x: talib.MA(x, timeperiod=50), axis = 0)
    HSI_MA200 = HSI_stock_df.apply(lambda x: talib.MA(x, timeperiod=200), axis = 0)
    
    compare_HSI_MA20 = pd.DataFrame(np.where(HSI_stock_df > HSI_MA20, 1, 0), index = HSI_stock_df.index)
    compare_HSI_MA20 = compare_HSI_MA20.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_HSI_MA50 = pd.DataFrame(np.where(HSI_stock_df > HSI_MA50, 1, 0), index = HSI_stock_df.index)
    compare_HSI_MA50 = compare_HSI_MA50.apply(lambda x:sum(x)/len(x), axis = 1)
    
    compare_HSI_MA200 = pd.DataFrame(np.where(HSI_stock_df > HSI_MA200, 1, 0), index = HSI_stock_df.index)
    compare_HSI_MA200 = compare_HSI_MA200.apply(lambda x:sum(x)/len(x), axis = 1)

    print('downloaded HSI')
    return pd.DataFrame(compare_DOW_MA20.tail(n=310)), pd.DataFrame(compare_DOW_MA50.tail(n=310)), pd.DataFrame(compare_DOW_MA200.tail(n=310)), pd.DataFrame(compare_NASDAQ_MA20.tail(n=310)), pd.DataFrame(compare_NASDAQ_MA50.tail(n=310)), pd.DataFrame(compare_NASDAQ_MA200.tail(n=310)), pd.DataFrame(compare_SPX_MA20.tail(n=310)), pd.DataFrame(compare_SPX_MA50.tail(n=310)), pd.DataFrame(compare_SPX_MA200.tail(n=310)), pd.DataFrame(compare_HSI_MA20.tail(n=310)), pd.DataFrame(compare_HSI_MA50.tail(n=310)), pd.DataFrame(compare_HSI_MA200.tail(n=310))



