import os
import sys


class ConstValue(object):
    class ConstError(TypeError):
        pass

    class ConstCaseError(ConstError):
        def __init__(self):
            pass

    def __setattr__(self, name, value):
        if name in self.__dict__:
            # if name in self.__dict__:
            raise (self.ConstError, 'Not allowed change const.{value}'.format(value=name))
        if not name.isupper():
            raise (self.ConstCaseError, "Const's name is not all uppercase")
        self.__dict__[name] = value

    def __delattr__(self, name):
        if name in self.__dict__:
            raise (self.ConstError, "Can't unbind const const instance attribute (%s)" % name)
        raise (AttributeError, "const instance has no attribute '%s'" % name)


def testCreateFile1():
    open('test.txt', 'a').close()

    open("test.txt", "w+").close()
    # w+ 会覆盖原文件.

    # 调用命令也可以
    import os
    os.system("cd.>test.txt")  # 会覆盖原文件.
    # 参考http: // stackoverflow.com / questions / 1158076 / implement - touch - using - python

    from pathlib import Path
    Path('test').touch()  # 不会覆盖原文件.


# testCreateFile1()


def replaceFilesBytes(sSrcPath='', sDestPath='', bsSrc=b'', bsDest=b''):
    const = ConstValue()
    const.CHUNK_SIZE = 2048

    print(sSrcPath)

    def read(file_obj):
        """
        逐件读取文件
        默认块大小：2KB
        """
        while True:
            data = file_obj.read(const.CHUNK_SIZE)  # 每次读取指定的长度
            if not data:
                break
            yield data

    def replaceFileBytes(sReplaceFilePath):
        sNewFilePath = sReplaceFilePath.replace(sSrcPath, sDestPath)
        sNewPath = os.path.dirname(sNewFilePath)
        if not os.path.exists(sNewPath):
            os.makedirs(sNewPath)
        wFile = open(sNewFilePath, 'wb')
        bsRemain = bytes(0)

        def receive(bsNew):
            nonlocal bsRemain
            bsTotal = bsRemain + bsNew
            index = bsTotal.rfind(bsSrc)
            if index == -1:
                bsSave = bsTotal[: len(bsTotal) - len(bsSrc)]
                bsRemain = bsTotal[len(bsTotal) - len(bsSrc):]
                wFile.write(bsSave)
            else:
                bsSave = bsTotal[0: index + len(bsSrc)]
                bsRemain = bsTotal[index + len(bsSrc):]
                bsSave = bsSave.replace(bsSrc, bsDest)
                wFile.write(bsSave)

        try:
            f = open(sReplaceFilePath, 'rb')
            if f is not None:
                for bsData in read(f):
                    receive(bsData)
                f.close()
        except IOError as e:
            print(str(e))

        # with open(sReplaceFilePath, 'rb', encoding='utf-8') as f:
        #     for bsData in read(f):
        #         receive(bsData)

        if len(bsRemain) > 0:
            wFile.write(bsRemain)
        wFile.close()

    extensions = ['.c', '.cpp', '.h', '.hpp', '.cxx']
    for sRoot, dirs, files in os.walk(sSrcPath):
        for sFile in files:
            (shotname, extension) = os.path.splitext(sFile)
            if extension in extensions:
                sFilePath = os.path.join(sRoot, sFile)
                print(sFilePath)
                replaceFileBytes(sFilePath)
        for sDir in dirs:
            print((os.path.join(sRoot, sDir).encode('utf-8')))


def replaceFilesBytes2(sSrcPath='', sDestPath=''):
    const = ConstValue()
    const.CHUNK_SIZE = 2048

    bsSrc = b';'
    bsDest = b'],['

    print(sSrcPath)

    def read(file_obj):
        """
        逐件读取文件
        默认块大小：2KB
        """
        while True:
            data = file_obj.read(const.CHUNK_SIZE)  # 每次读取指定的长度
            if not data:
                break
            yield data

    def replaceFileBytes(sReplaceFilePath):
        sNewFilePath = sReplaceFilePath.replace(sSrcPath, sDestPath)
        sNewPath = os.path.dirname(sNewFilePath)
        if not os.path.exists(sNewPath):
            os.makedirs(sNewPath)
        wFile = open(sNewFilePath, 'wb')
        bsRemain = bytes(0)

        def receive(bsNew, bEof):
            nonlocal bsRemain
            bsTotal = bsRemain + bsNew
            index = bsTotal.rfind(bsSrc)
            if index == -1:
                bsSave = bsTotal[: len(bsTotal) - len(bsSrc)]
                bsRemain = bsTotal[len(bsTotal) - len(bsSrc):]
                wFile.write(bsSave)
            else:
                bsSave = bsTotal[0: index + len(bsSrc)]
                bsRemain = bsTotal[index + len(bsSrc):]
                if bEof:
                    bsSave = bsSave.replace(bsSrc, bsDest, bsSave.count(bsSrc) - 1)
                    bsSave = bsSave.replace(bsSrc, b']]')
                else:
                    bsSave = bsSave.replace(bsSrc, bsDest)
                wFile.write(bsSave)

        try:
            statinfo = os.stat(sReplaceFilePath)
            iFileSize = statinfo.st_size
            iDeal = 0
            f = open(sReplaceFilePath, 'rb')
            if f is not None:
                for bsData in read(f):
                    if iDeal == 0:
                        bsData = b'[[' + bsData
                    iDeal += len(bsData)
                    receive(bsData, iDeal >= iFileSize)
                f.close()
        except IOError as e:
            print(str(e))

        # with open(sReplaceFilePath, 'rb', encoding='utf-8') as f:
        #     for bsData in read(f):
        #         receive(bsData)

        if len(bsRemain) > 0:
            wFile.write(bsRemain)
        wFile.close()

    for sRoot, dirs, files in os.walk(sSrcPath):
        for sFile in files:
            sFilePath = os.path.join(sRoot, sFile)
            print(sFilePath)
            replaceFileBytes(sFilePath)
        for sDir in dirs:
            print((os.path.join(sRoot, sDir).encode('utf-8')))


def mainReplace():
    # replaceFilesBytes2(r'/eee/System', r'/eee/System-')
    # sSrc = bytes.fromhex('efbbbf')
    # sDest = b''
    # replaceFilesBytes(r'/ddd/specialty/leetcode/algorithms/java/src/searchA2DMatrixII', r'/ddd/specialty/leetcode/algorithms/java/src-', sSrc, sDest)
    sSrc = bytes.fromhex('0D0A')
    sDest = bytes.fromhex('0A')
    replaceFilesBytes(r'/Users/oudream/Downloads/vdi', r'/Users/oudream/Downloads/vdi-', sSrc, sDest)


if __name__ == '__main__':
    mainReplace()
else:
    mainReplace()
