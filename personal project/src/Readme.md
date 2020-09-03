# Percentage of index’s stock above MA checker

##### Please noted that this is only for my friend's usage, no other version will be provided.

### installation
Step 1

Please go to [TA-Lib download page](https://www.lfd.uci.edu/~gohlke/pythonlibs/#ta-lib) and download `TA_Libxxxxxxxxxxxxx_amd64.whl` according to your python version.

Step 2
Type the following command on anaconda prompt. Please modify it according to your version
```{sh}
# change your directory according to the location of the .whl file
cd C:\Users\admin\Desktop\stock_above_MA
#just copy the file name of the .whl file you downloaded
pip install TA_Lib-0.4.18-cp37-cp37m-win_amd64.whl
```

Step 3
Open `get_all_stock_list.py` and `mv_avg.py`, find `os.chdir` and change the path name to `X:\xxx\xxx\stock_above_MA_checker\src` in both file.

Step 4
Open `get_all_stock_list.py` and change the following command to your path `pd.read_csv(r'C:\xxx\xxx\xxx\stock_above_MA_checker\csv\hk_stock_list.csv')['HSI'].tolist()`

Step 5
Type the following command on anaconda promp.
```sh
# change your directory according to the location of requirements.txt
cd C:\Users\admin\Desktop\stock_above_MA
pip install -r requirements.txt 
```
### Execution
Type the following command on anaconda promp.
```sh
# change your directory to /src
cd C:\Users\admin\Desktop\stock_above_MA\src
python google_API.py
```


