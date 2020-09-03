import os
import gspread
from gspread_dataframe import set_with_dataframe
from oauth2client.service_account import ServiceAccountCredentials
os.chdir(r'C:\Users\admin\Desktop\stock_above_MA_checker\src')
from mv_avg import get_compared_df

# credit key
scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
credentials = ServiceAccountCredentials.from_json_keyfile_name(os.path.join('..','json','stock-compare-with-ma-2f8df22ab913.json'), scope)
gc = gspread.authorize(credentials)

sh = gc.open('stock_above_indexMA_ratio')

#load df
compare_DOW_MA20, compare_DOW_MA50, compare_DOW_MA200, compare_NASDAQ_MA20, compare_NASDAQ_MA50, compare_NASDAQ_MA200, compare_SPX_MA20, compare_SPX_MA50, compare_SPX_MA200, compare_HSI_MA20, compare_HSI_MA50, compare_HSI_MA200 = get_compared_df()

df_list = {'compare_DOW_MA20': compare_DOW_MA20, 'compare_DOW_MA50':compare_DOW_MA50, 'compare_DOW_MA200':compare_DOW_MA200, 'compare_NASDAQ_MA20':compare_NASDAQ_MA20, 'compare_NASDAQ_MA50':compare_NASDAQ_MA50, 'compare_NASDAQ_MA200':compare_NASDAQ_MA200, 'compare_SPX_MA20':compare_SPX_MA20, 'compare_SPX_MA50':compare_SPX_MA50, 'compare_SPX_MA200':compare_SPX_MA200, 'compare_HSI_MA20':compare_HSI_MA20, 'compare_HSI_MA50':compare_HSI_MA50, 'compare_HSI_MA200':compare_HSI_MA200}
df_list_keys = df_list.keys()

#upload df
def upload(compare_df, compare_df_keys):
    df_name = str(compare_df_keys).split('e_')[1]
    try:
        sh.add_worksheet(title = df_name, rows = str(compare_df.shape[0]+100), cols = '20')
    except:
        pass
    ws = sh.worksheet(df_name)
    set_with_dataframe(ws, compare_df, row = 1, col = 1, include_index = True, include_column_header = False)
    
#upload
for df in df_list:
    upload(df_list[df], df)
    print('updated'+' '+df)
