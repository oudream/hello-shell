import sys
import os
import shutil
import re
import inspect

'''
srcfile = 'a/long/long/path/to/file.py'
dstroot = '/home/myhome/new_folder'
assert not os.path.isabs(srcfile)
dstdir =  os.path.join(dstroot, os.path.dirname(srcfile))
os.makedirs(dstdir) # create all directories, raise an error if it already exists
shutil.copy(srcfile, dstdir)
print 'Number of arguments:', len(sys.argv), 'arguments.'
print 'Argument List:', str(sys.argv)
'''


class CopyFile:
    @staticmethod
    def runFromSysArgv():

        def printArgvMan():
            man = '''
                case 1 : -sf /dirName/appName -tf /dirName
                case 2 : -sf /dirName/appName
                case 3 : -sf appName -ct debug|release
            '''
            print(man)

        bGoodArgv = False
        dictArgv = dict(zip(*[iter(sys.argv[1:])] * 2))
        sf = dictArgv.get('-sf')
        ct = dictArgv.get('-ct')
        tf = dictArgv.get('-tf')
        sfDir = None
        rootDir = None
        sfBasename = None
        sfPrefixName, sfSuffixName = None, None
        sfDirBasename = None
        tfDir = None

        # case 1
        if sf and tf:
            if os.path.isfile(sf):
                sfDir = os.path.dirname(sf)
            else:
                print('-sf is invalid.')
                printArgvMan()
                return
            if os.path.isdir(tf):
                tfDir = tf
            else:
                print('-tf is invalid.')
                printArgvMan()
                return
        if sf:
            # case 2
            if os.path.isfile(sf):
                sfDir = os.path.dirname(sf)
            # case 3
            elif len(sf) > 0 and ct:
                frameinfo = inspect.getframeinfo(inspect.currentframe())
                if os.path.isabs(frameinfo.filename):
                    deployDir = os.path.dirname(os.path.dirname(
                        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(frameinfo.filename))))))
                else:
                    deployDir = os.path.dirname(os.path.dirname(
                        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(
                            os.path.join(os.getcwd(), frameinfo.filename)
                        ))))))
                sfDirBasename = 'bin_d' if re.match('debug', ct, re.IGNORECASE) else 'bin'
                if sys.platform == 'win32' or sys.platform == 'cygwin':
                    sfDir = os.path.join(deployDir, 'deploy/win32/' + sfDirBasename)
                else:
                    sfDir = os.path.join(deployDir, 'deploy/unix/' + sfDirBasename)
            else:
                print('-sf is invalid.')
                printArgvMan()
                return
        else:
            print('-sf is invalid.')
            printArgvMan()
            return
        if sfDir is None:
            printArgvMan()
            return
        if not os.path.exists(sfDir):
            print('-sf do not exist. ', sf)
            printArgvMan()
            return
        rootDir = os.path.dirname(sfDir)
        if not os.path.exists(rootDir):
            print('-sf is root. ', sf)
            return
        sfBasename = os.path.basename(sf)
        sfPrefixName, sfSuffixName = os.path.splitext(sfBasename)
        sfDirBasename = os.path.basename(sfDir)
        if tf is None:
            index = sfDirBasename.rfind('_')
            if index == -1:
                tfDir = sfDirBasename + '_qt'
            else:
                tfDir = sfDirBasename[0:index] + '_qt' + sfDirBasename[index:]
            tfDir = os.path.join(rootDir, tfDir)
        if tfDir is None:
            printArgvMan()
            return
        if not os.path.exists(tfDir):
            print('target dir do not exist. ', tfDir)
            return
            # os.makedirs(tfDir)
        for filename in os.listdir(sfDir):
            if os.path.splitext(filename)[0] == sfPrefixName:
                sfFilePath = os.path.join(sfDir, filename)
                tfFilePath = os.path.join(tfDir, filename)
                if not os.path.exists(sfFilePath) or not os.path.isfile(sfFilePath):
                    continue
                if os.path.exists(tfFilePath):
                    sfMtime = os.path.getmtime(sfFilePath)
                    sfSize = os.path.getsize(sfFilePath)
                    tfMtime = os.path.getmtime(tfFilePath)
                    tfSize = os.path.getsize(tfFilePath)
                    if (sfMtime != tfMtime) and (sfSize != tfSize):
                        print('copy by cover : ', filename, shutil.copy(sfFilePath, tfDir))
                    else:
                        print('same file :', filename, sfFilePath)
                else:
                    print('copy by new : ', filename, shutil.copy(sfFilePath, tfDir))


CopyFile.runFromSysArgv()
