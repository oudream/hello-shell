import os
import re


class Message(object):
    def __init__(self, filepath, message, fetching, line):
        self.filepath = os.path.normpath(filepath)
        self.message = message
        self.fetching = fetching
        self.line = line
        self.filename = os.path.basename(self.filepath)
        ps = self.filepath.split(os.sep)
        if len(ps) > 4:
            self.pack = ps[4]
        else:
            self.pack = ""


messages = []


def fetch2file(r, src):
    """ fetch middle word by (l, r)
    """
    extensions = ['.java']
    for sRoot, dirs, files in os.walk(src):
        for sFile in files:
            (shotname, extension) = os.path.splitext(sFile)
            if extension in extensions:
                sFilePath = os.path.join(sRoot, sFile)
                print(sFilePath)
                with open(sFilePath, 'r', encoding='UTF-8') as openfileobject:
                    index = 0
                    for line in openfileobject:
                        index += 1
                        a = re.findall(r, line)
                        if len(a) > 0:
                            m = a[0]
                            messages.append(Message(sFilePath, m, r, index))
        for sDir in dirs:
            print((os.path.join(sRoot, sDir).encode('utf-8')))


def mainFetch2file():
    d = [r'getErrorEntity[(]["](.*?)["][)]', r'throw\ new\ ShopException[(]["](.*?)["][)]',
         r'throw\ new\ Exception[(]["](.*?)["][)]']
    for i in d:
        fetch2file(i, r"D:\twant\twant\src")

    try:
        f = open("d:/tmp/話術-v1.0.1.csv", 'w')
        f.write("代碼包名,文件名,消息話術,行號,抓取字符串,文件全路徑\n")
        for m in messages:
            f.write("{},{},{},{},{},{}\n".format(m.pack, m.filename, m.message.replace(',', '，'), m.line, m.fetching, m.filepath))
        f.close()
    except IOError as e:
        print((str(e)))


if __name__ == '__main__':
    mainFetch2file()
else:
    mainFetch2file()
