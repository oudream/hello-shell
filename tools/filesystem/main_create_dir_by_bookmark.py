import os
import re


class BookMark:
    @staticmethod
    def createdir(fp, root):

        def read(fo):
            while True:
                line = fo.readline()
                if not line:
                    break
                yield line

        if not os.path.exists(root):
            try:
                os.makedirs(root)
            except IOError as e:
                print(str(e))
                return

        if not os.path.exists(fp):
            print('don exists the path : ', fp)
            return
        try:
            f = open(fp, 'rb')
            if f is not None:
                dirs = {1:root}
                for data in read(f):
                    res = r'(.*?)<DT><H3 .*>(.*?)</H3>'
                    mm = re.findall(res, data.decode('utf-8'), re.S | re.M)
                    if len(mm) < 1:
                        continue
                    m = mm[0]
                    space_str, dir_name = m
                    deep = len(space_str) // 4
                    if deep <= 1 or len(dir_name) < 1:
                        print('warning : createDirByBookmark deep <= 1 and len(dirName) < 1 .')
                        continue
                    parent_path = dirs.get(deep-1)
                    if parent_path is None:
                        print('error : createDirByBookmark parent_path is None .')
                        continue
                    path = os.path.join(parent_path, dir_name)
                    dirs[deep] = path
                    if os.path.exists(path):
                        print('ignore : path exists : ', path)
                        continue
                    else:
                        print('do : path mkdir : ', path)
                        os.mkdir(path)
                f.close()
        except IOError as e:
            print(str(e))


def run():
    fp = '/eee/oudream/bookmarks/chrome.bookmarks.html'
    root = '/eee/note'
    BookMark.createdir(fp, root)


if __name__ == '__main__':
    run()
else:
    run()
