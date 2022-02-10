#!/usr/bin/python3

import re
import os
import time

gCount = 0
gList1 = []
gList2 = []


def tool_rename1():
    global gCount
    global gList1
    global gList2

    def print_files(path):
        global gCount
        global gList1
        global gList2
        ls_dir = os.listdir(path)

        dirs = [i for i in ls_dir if os.path.isdir(os.path.join(path, i))]
        if dirs:

            for i in dirs:
                print_files(os.path.join(path, i))

        # files = [i for i in lsdir if os.path.isfile(os.path.join(path, i))]

        # for f in files:  #列出所有文件(包括子目录下的文件)

        for f in dirs:  # 列出所有目录(包括子目录下的目录)

            sss = (os.path.join(path, f))

            if os.path.isdir(sss):  # 判断路径是否为目录

                # print(sss)

                for fn1 in os.listdir(sss):
                    f1 = os.path.join(sss, fn1)
                    if os.path.isfile(f1):
                        if 'gcl' in fn1 and 'cmake-build-debug' not in f1:
                            # m = re.search('gcl', fn1, re.IGNORECASE)
                            # if m and 'cmake-build-debug' not in f1:
                            fn2 = fn1.replace("gcl", "i3ds")
                            f2 = os.path.join(sss, fn2)
                            os.rename(f1, f2)
                            print(f1)
                            print(f2)
                            gCount = gCount + 1
                    elif os.path.isdir(f1):
                        if 'gcl' in fn1 and 'cmake-build-debug' not in f1:
                            fn2 = fn1.replace("gcl", "i3ds")
                            f2 = os.path.join(sss, fn2)
                            gList1.append(f1)
                            gList2.append(f2)
                            gCount = gCount + 1

                        # pre2, suf2 = os.path.splitext(fn1)
                        # if suf2.lower() == '.txt':
                        #     print(f1)

        return

    print_files(r'C:\dev\limi\i3ds')
    print(gCount)
    print(len(gList1))
    print(len(gList2))

    # for d1 in gList1:
    #     print(d1)
    for i in range(len(gList1)):
        os.rename(gList1[i], gList2[i])
        print(gList2[i])
    # for d2 in gList2:
    #     os.rename(f1, f2)
    #
    #     print(d2)


if __name__ == '__main__':
    tool_rename1()
else:
    tool_rename1()
