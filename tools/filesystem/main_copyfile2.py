import os
import shutil

def copy7rename2(srcPath='', dstPath=''):
    for dn1 in os.listdir(srcPath):
        print(dn1)
        fp1 = os.path.join(srcPath, dn1)
        if os.path.isdir(fp1):
            fp2 = os.path.join(dstPath, dn1)
            if not os.path.exists(fp2):
                os.makedirs(fp2)
            i = 0
            for fn1 in os.listdir(fp1):
                f1 = os.path.join(fp1, fn1)
                if os.path.isfile(f1):
                    pre2, suf2 = os.path.splitext(fn1)
                    if (suf2.lower() == '.txt'):
                        i = i + 1
                        pre2 = dn1+'.'+str(i)
                        c2 = os.path.join(fp2, pre2+fn1)
                        r2 = os.path.join(fp2, pre2+'.cpp')
                        shutil.copy2(f1, c2)
                        os.rename(c2, r2)
                        shutil.copy2(f1, c2)
                        print(f1, " copy7rename: ", c2, r2)

def copy7rename():
    copy7rename2(r'/ddd/specialty/leetcode/referto/analysis_of_algorithm', r'/ddd/specialty/leetcode/referto/analysis_of_algorithm2')

if __name__ == '__main__':
    copy7rename()
else:
    copy7rename()