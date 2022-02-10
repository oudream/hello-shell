import os


def CreateProFileA(root, files, toFileName):
    s1 = r"DEFINES += PROJECT_TEMPLATE_LIB_STATIC"
    s1 = s1 + '\n' + r"include($$PWD/../../../../../qtproject.pri)"
    s2 = r"HEADERS += \\ "
    s3 = r"    {0} \ "
    s4 = r"SOURCES += \ "
    s5 = r"    {0} \ "
    s6 = r"OTHER_FILES += \ "
    s7 = r"    {0} \ "
    sl2 = []
    sl2.append(s2)
    sl4 = []
    sl4.append(s4)
    sl6 = []
    sl6.append(s6)
    for name in files:
        sFileName = os.path.basename(name)
        sFirstName, sLastName = os.path.splitext(sFileName)
        if sLastName.upper() == '.H' or sLastName.upper() == '.HPP':
            sl2.append(s3.format(sFileName))
        elif sLastName.upper() == '.C' or sLastName.upper() == '.CPP':
            sl4.append(s5.format(sFileName))
        else:
            sl6.append(s7.format(sFileName))

    f = open(root + '\\' + toFileName, 'w')

    f.write(s1 + '\n\n')
    f.write('\n')

    for s in sl2:
        f.write(s + '\n')

    f.write('\n\n')

    for s in sl4:
        f.write(s + '\n')

    f.write('\n\n')

    for s in sl6:
        f.write(s + '\n')


def createProFilesA(sFilePath):
    gsl = []
    for root, dirs, files in os.walk():
        sDrive, sDir = os.path.split(root)
        gsl.append(sDir + ' \\')
        CreateProFileA(root, files, sDir + '.pro')

    for s in gsl:
        print(s)


def createProFileB(sDir):
    s1 = r"DEFINES += PROJECT_TEMPLATE_LIB_STATIC"
    s1 = s1 + '\n' + r"include($$PWD/../../../../../qtproject.pri)"
    s2 = r"HEADERS += \\ "
    s3 = r"    {0} \ "
    s4 = r"SOURCES += \ "
    s5 = r"    {0} \ "
    s6 = r"OTHER_FILES += \ "
    s7 = r"    {0} \ "
    sl2 = [];
    sl2.append(s2);
    sl4 = [];
    sl4.append(s4);
    sl6 = [];
    sl6.append(s6);
    for root, dirs, files in os.walk(sDir):
        sSubDirName = root.replace(sDir, '')
        if sSubDirName.startswith('/') or sSubDirName.startswith('\\'):
            sSubDirName = sSubDirName[1:]
        for name in files:
            sFileName = os.path.basename(name)
            sFirstName, sLastName = os.path.splitext(sFileName)
            if len(sSubDirName) > 0:
                sFileName = '$$PWD/' + sSubDirName + '/' + sFileName
            else:
                sFileName = '$$PWD/' + sFileName

            if sLastName.upper() == '.H' or sLastName.upper() == '.HPP':
                sl2.append(s3.format(sFileName))
            elif sLastName.upper() == '.C' or sLastName.upper() == '.CPP':
                sl4.append(s5.format(sFileName))
            else:
                sl6.append(s7.format(sFileName))

    sDriveName, sDirName = os.path.split(sDir)
    sFileName = sDir + '\\{0}.pro'.format(sDirName)
    f = open(sFileName, 'w')

    f.write(s1 + '\n\n')
    f.write('\n')

    for s in sl2:
        f.write(s + '\n')

    f.write('\n\n')

    for s in sl4:
        f.write(s + '\n')

    f.write('\n\n')

    for s in sl6:
        f.write(s + '\n')

    print(sFileName)


def createProFilesB(sFilePath):
    isRealDir = lambda x: os.path.isdir(x) and not os.path.islink(x)
    ##    appendFileName = lambda x , y : x.endswith( '\\' ) and x + y or x + '\\' + y
    ##    appendFileName = lambda x , y : ( x.endswith( '\\' ) and [x + y] or [x + '\\' + y])[0]
    appendFileName = lambda x, y: (x + '\\' + y, x + y)[x.endswith('\\') and 1 or 0]
    if not isRealDir(sFilePath):
        print(("Error : " + sFilePath + "not is dir, return!"))
        return
    lsDirName2 = []
    lsDirName = os.listdir(sFilePath)
    for sDirName in lsDirName:
        sDir = appendFileName(sFilePath, sDirName)
        if not isRealDir(sDir):
            continue
        lsDirName2.append(sDirName)
        createProFileB(sDir)

    for sDirName in lsDirName2:
        print((sDirName + ' \\'))


if __name__ == '__main__':
    createProFileB(r"D:\code.c\linux\linux0d11cn")
