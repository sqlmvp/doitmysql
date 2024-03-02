from datetime import datetime, timedelta

import pymysql
import pandas as pd
import yfinance as yf





mysql_conn = pymysql.connect(host='localhost', user='root', password='doitmysql', db='us_stock')


def getCompany():
    
    mysql_cur = mysql_conn.cursor()

    today = datetime.today() + timedelta(days=1)

    try:
        mysql_cur.execute("select symbol, company_name, ipo_year, last_crawel_date_stock from us_stock.nasdaq_company where is_delete is null;")
        results = mysql_cur.fetchall()
        print(results)    
        

        for row in results:
            _symbol = row[0]
            _company_name = row[1]
            
            if row[2] is None or row[2] == 0:
                _ipo_year = '1970'
            else:
                _ipo_year = row[2]
            
            if row[3] is None:
                _last_crawel_date_stock = str(_ipo_year) + '-01-01'
            else:
                _last_crawel_date_stock = row[3]

            print (_symbol)
            if "." in _symbol:
                print(_symbol)
            else:
                if "/" in _symbol:
                    print(_symbol)
                else:
                    getStock(_symbol, _last_crawel_date_stock, today.strftime("%Y-%m-%d"))
                    
                    
    except Exception as e:
        print ("error : " + str(e))
        mysql_conn.commit()
        mysql_conn.close()
        
        return {'error': str(e)}


def getStock(_symbol, _start_date, _end_date):
    
    mysql_cur = mysql_conn.cursor()

    mysql_cur.execute("delete from us_stock.stock where date >= %s and date <= %s and symbol = %s", (_start_date, _end_date, _symbol))
    mysql_conn.commit()

    try:
        #yf.download already returns a DataFrame.
        stock_price = yf.download(_symbol, start=_start_date, end=_end_date)
        print(stock_price)
        
        for index, row in stock_price.iterrows():
            _date = index.strftime("%Y-%m-%d")
            _open = str(row["Open"])
            _high = str(row["High"])
            _low = str(row["Low"])
            _close = str(row["Close"])
            _adj_close = str(row["Adj Close"])
            _volume = str(row["Volume"])
        
            mysql_cur.execute("insert into us_stock.stock (date, symbol, open, high, low, close, adj_close, volume) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", (_date, _symbol, _open, _high, _low, _close, _adj_close, _volume))
        mysql_conn.commit()

        
        mysql_cur.execute("update us_stock.nasdaq_company set open = %s, high = %s, low = %s, close = %s, adj_close = %s, volume = %s, last_crawel_date_stock = %s where symbol = %s", (_open, _high, _low, _close, _adj_close, _volume, _date, _symbol))
        mysql_conn.commit()
        
    except Exception as e:
        print ("error : " + str(e))
        mysql_conn.commit()
        mysql_conn.close()
        
        return {'error': str(e)}
    

if __name__ == '__main__':
# execute only if run as a script
    getCompany()
