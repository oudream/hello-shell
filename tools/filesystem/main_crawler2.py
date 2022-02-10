import time
import urllib.request
import urllib.parse
import urllib.error
import numpy as np
from bs4 import BeautifulSoup
from openpyxl import Workbook
import re

if __name__ == '__main__':
    for i in range(0, 15*10, 15):
        url = 'http://www.douban.com/tag/' + urllib.parse.quote('个人管理') + '/book?start={}'.format(i)
        try:
            req = urllib.request.Request(url)
            sec = np.random.rand() * 5
            time.sleep(sec)
            source_code = urllib.request.urlopen(req).read()
            plain_text = source_code.decode('utf-8')
            try:
                fp = "/fff/tmp/{}.txt".format(time.time())
                f = open(fp, 'w')
                if f is not None:
                    f.write(plain_text)
                    f.close()
                    print('save 2 file: ', fp, '. \nsleep: ', sec)
            except (IOError) as e:
                print(str(e))
            # soup = BeautifulSoup(plain_text)
        except (urllib.error.HTTPError, urllib.error.URLError) as e:
            print(e)
