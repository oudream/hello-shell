import os
import random
import re


def testMath20170724():
    try:
        fSub = open("/fff/tmp/oukings/math20170724-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170724-answer.txt", 'w')
        if fSub != None:
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')

            for v in range(31, 35, 1):
                for i in range(10, 20, 1):
                    for j in range(10, 20, 1):
                        if (i + j == v):
                            fSub.write('{} + {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} + {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')

            for i in range(11, 14, 1):
                for j in range(10, 20, 1):
                    fSub.write('{} × {} = ( ) \r\n'.format(i, j))
                    fAns.write('{} × {} = ( {} ) \r\n'.format(i, j, i*j))

            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')

            for v in range(11, 14, 1):
                for i in range(20, 30, 1):
                    for j in range(10, 20, 1):
                        if (i - j == v):
                            fSub.write('{} - {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} - {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')

            for v in range(2, 5, 1):
                for i in range(30, 20, -1):
                    for j in range(1, 20, 1):
                        if (i / j == v):
                            fSub.write('{} ÷ {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))


# testMath20170724()




def testMath20170725():
    try:
        fSub = open("/fff/tmp/oukings/math20170725-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170725-answer.txt", 'w')
        if fSub != None:
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')

            for v in range(35, 39, 1):
                for i in range(10, 20, 1):
                    for j in range(10, 20, 1):
                        if (i + j == v):
                            fSub.write('{} + {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} + {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')

            for i in range(14, 17, 1):
                for j in range(10, 20, 1):
                    fSub.write('{} × {} = ( ) \r\n'.format(i, j))
                    fAns.write('{} × {} = ( {} ) \r\n'.format(i, j, i*j))

            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')

            for v in range(14, 17, 1):
                for i in range(20, 30, 1):
                    for j in range(10, 20, 1):
                        if (i - j == v):
                            fSub.write('{} - {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} - {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')

            for v in range(5, 8, 1):
                for i in range(30, 20, -1):
                    for j in range(1, 20, 1):
                        if (i / j == v):
                            fSub.write('{} ÷ {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))


# testMath20170725()

def testMath20170726():
    try:
        fSub = open("/fff/tmp/oukings/math20170726-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170726-answer.txt", 'w')
        if fSub != None:
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')

            for v in range(39, 43, 1):
                for i in range(15, 25, 1):
                    for j in range(15, 25, 1):
                        if (i + j == v):
                            fSub.write('{} + {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} + {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')

            for i in range(17, 20, 1):
                for j in range(10, 20, 1):
                    fSub.write('{} × {} = ( ) \r\n'.format(i, j))
                    fAns.write('{} × {} = ( {} ) \r\n'.format(i, j, i*j))

            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')

            for v in range(17, 20, 1):
                for i in range(23, 33, 1):
                    for j in range(10, 20, 1):
                        if (i - j == v):
                            fSub.write('{} - {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} - {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')

            for v in range(8, 11, 1):
                for i in range(40, 30, -1):
                    for j in range(1, 20, 1):
                        if (i / j == v):
                            fSub.write('{} ÷ {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))


# testMath20170726()


def testMath20170727():
    try:
        fSub = open("/fff/tmp/oukings/math20170727-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170727-answer.txt", 'w')
        if fSub != None:
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')

            for v in range(43, 47, 1):
                for i in range(18, 29, 1):
                    for j in range(18, 26, 1):
                        if (i + j == v):
                            fSub.write('{} + {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} + {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')

            for i in range(21, 23, 1):
                for j in range(21, 30, 1):
                    fSub.write('{} × {} = ( ) \r\n'.format(i, j))
                    fAns.write('{} × {} = ( {} ) \r\n'.format(i, j, i*j))

            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')

            for v in range(21, 24, 1):
                for i in range(41, 53, 1):
                    for j in range(21, 30, 1):
                        if (i - j == v):
                            fSub.write('{} - {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} - {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')

            for v in range(11, 15, 1):
                for i in range(100, 10, -1):
                    for j in range(2, 20, 1):
                        if (i / j == v):
                            fSub.write('{} ÷ {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))


# testMath20170727()


def testMath20170728():
    try:
        fSub = open("/fff/tmp/oukings/math20170728-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170728-answer.txt", 'w')
        if fSub != None:
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')

            for v in range(47, 51, 1):
                for i in range(22, 32, 1):
                    for j in range(18, 26, 1):
                        if (i + j == v):
                            fSub.write('{} + {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} + {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')

            for i in range(23, 25, 1):
                for j in range(21, 30, 1):
                    fSub.write('{} × {} = ( ) \r\n'.format(i, j))
                    fAns.write('{} × {} = ( {} ) \r\n'.format(i, j, i*j))

            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')

            for v in range(24, 27, 1):
                for i in range(45, 55, 1):
                    for j in range(21, 30, 1):
                        if (i - j == v):
                            fSub.write('{} - {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} - {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')

            for v in range(16, 19, 1):
                for i in range(100, 10, -1):
                    for j in range(2, 20, 1):
                        if (i / j == v):
                            fSub.write('{} ÷ {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))


# testMath20170728()


def testMath20170731():
    try:
        fSub = open("/fff/tmp/oukings/math20170731-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170731-answer.txt", 'w')
        if fSub != None:
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')

            for v in range(51, 55, 1):
                for i in range(26, 36, 1):
                    for j in range(18, 26, 1):
                        if (i + j == v):
                            fSub.write('{} + {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} + {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')

            for i in range(25, 27, 1):
                for j in range(21, 30, 1):
                    fSub.write('{} × {} = ( ) \r\n'.format(i, j))
                    fAns.write('{} × {} = ( {} ) \r\n'.format(i, j, i*j))

            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')

            for v in range(27, 30, 1):
                for i in range(48, 58, 1):
                    for j in range(21, 30, 1):
                        if (i - j == v):
                            fSub.write('{} - {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} - {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')

            for v in range(19, 22, 1):
                for i in range(100, 10, -1):
                    for j in range(2, 20, 1):
                        if (i / j == v):
                            fSub.write('{} ÷ {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))


# testMath20170731()


def testMath20170801():
    try:
        fSub = open("/fff/tmp/oukings/math20170801-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170801-answer.txt", 'w')
        if fSub != None:
            fSub.write('欧阳泓梓 - 20170801 - 数学题：\r\n')
            fAns.write('欧阳泓梓 - 20170801 - 数学题：\r\n')
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')

            for v in range(55, 59, 1):
                for i in range(25, 35, 1):
                    for j in range(20, 30, 1):
                        if (i + j == v):
                            fSub.write('{} + {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} + {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')

            for i in range(27, 30, 1):
                for j in range(31, 40, 1):
                    fSub.write('{} × {} = ( ) \r\n'.format(i, j))
                    fAns.write('{} × {} = ( {} ) \r\n'.format(i, j, i*j))

            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')

            for v in range(31, 34, 1):
                for i in range(62, 72, 1):
                    for j in range(31, 40, 1):
                        if (i - j == v):
                            fSub.write('{} - {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} - {} = ( {} ) \r\n'.format(i, j, v))

            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')

            for v in range(22, 25, 1):
                for i in range(199, 10, -1):
                    for j in range(2, 30, 1):
                        if (i / j == v):
                            fSub.write('{} ÷ {} = ( ) \r\n'.format(i, j))
                            fAns.write('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))

# testMath20170801()


def testMath20170802():
    try:
        fSub = open("/fff/tmp/oukings/math20170802-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170802-answer.txt", 'w')
        if fSub != None:
            fSub.write('欧阳泓梓 - 20170802 - 数学题：\r\n')
            fAns.write('欧阳泓梓 - 20170802 - 数学题：\r\n')

            subs = []
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')
            for v in range(61, 65, 1):
                for i in range(35, 45, 1):
                    for j in range(20, 30, 1):
                        if (i + j == v):
                            subs.append('{} + {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')
            for i in range(31, 34, 1):
                for j in range(31, 40, 1):
                    subs.append('{} × {} = ( {} ) \r\n'.format(i, j, i*j))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')
            for v in range(34, 37, 1):
                for i in range(65, 75, 1):
                    for j in range(31, 40, 1):
                        if (i - j == v):
                            subs.append('{} - {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')
            for v in range(25, 28, 1):
                for i in range(250, 10, -1):
                    for j in range(2, 30, 1):
                        if (i / j == v):
                            subs.append('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))

# testMath20170802()


def testMath20170803():
    try:
        fSub = open("/fff/tmp/oukings/math20170803-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170803-answer.txt", 'w')
        if fSub != None:
            fSub.write('欧阳泓梓 - 20170803 - 数学题：\r\n')
            fAns.write('欧阳泓梓 - 20170803 - 数学题：\r\n')

            subs = []
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')
            for v in range(75, 79, 1):
                for i in range(35, 45, 1):
                    for j in range(30, 40, 1):
                        if (i + j == v):
                            subs.append('{} + {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')
            for i in range(34, 37, 1):
                for j in range(31, 40, 1):
                    subs.append('{} × {} = ( {} ) \r\n'.format(i, j, i*j))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')
            for v in range(34, 37, 1):
                for i in range(65, 75, 1):
                    for j in range(31, 40, 1):
                        if (i - j == v):
                            subs.append('{} - {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')
            for v in range(28, 31, 1):
                for i in range(299, 55, -1):
                    for j in range(2, 30, 1):
                        if (i / j == v):
                            subs.append('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))

# testMath20170803()



def testMath20170804():
    try:
        fSub = open("/fff/tmp/oukings/math20170804-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170804-answer.txt", 'w')
        if fSub != None:
            fSub.write('欧阳泓梓 - 20170804 - 数学题：\r\n')
            fAns.write('欧阳泓梓 - 20170804 - 数学题：\r\n')

            subs = []
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')
            for v in range(79, 83, 1):
                for i in range(35, 45, 1):
                    for j in range(34, 44, 1):
                        if (i + j == v):
                            subs.append('{} + {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')
            for i in range(37, 40, 1):
                for j in range(31, 40, 1):
                    subs.append('{} × {} = ( {} ) \r\n'.format(i, j, i*j))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')
            for v in range(37, 40, 1):
                for i in range(68, 78, 1):
                    for j in range(31, 40, 1):
                        if (i - j == v):
                            subs.append('{} - {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')
            for v in range(31, 34, 1):
                for i in range(399, 61, -1):
                    for j in range(2, 30, 1):
                        if (i / j == v):
                            subs.append('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))

# testMath20170804()


def testMath20170809():
    try:
        fSub = open("/fff/tmp/oukings/math20170809-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170809-answer.txt", 'w')
        if fSub != None:
            fSub.write('欧阳泓梓 - 20170809 - 数学题：\r\n')
            fAns.write('欧阳泓梓 - 20170809 - 数学题：\r\n')

            subs = []
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')
            for v in range(83, 87, 1):
                for i in range(39, 49, 1):
                    for j in range(34, 44, 1):
                        if (i + j == v):
                            subs.append('{} + {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')
            for i in range(40, 43, 1):
                for j in range(31, 40, 1):
                    subs.append('{} × {} = ( {} ) \r\n'.format(i, j, i*j))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')
            for v in range(40, 43, 1):
                for i in range(72, 82, 1):
                    for j in range(31, 40, 1):
                        if (i - j == v):
                            subs.append('{} - {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')
            for v in range(34, 37, 1):
                for i in range(449, 69, -1):
                    for j in range(2, 30, 1):
                        if (i / j == v):
                            subs.append('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))

# testMath20170809()


def testMath20170810():
    try:
        fSub = open("/fff/tmp/oukings/math20170810-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170810-answer.txt", 'w')
        if fSub != None:
            fSub.write('欧阳泓梓 - 20170810 - 数学题：\r\n')
            fAns.write('欧阳泓梓 - 20170810 - 数学题：\r\n')

            subs = []
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')
            for v in range(87, 91, 1):
                for i in range(44, 54, 1):
                    for j in range(34, 44, 1):
                        if (i + j == v):
                            subs.append('{} + {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')
            for i in range(44, 47, 1):
                for j in range(31, 40, 1):
                    subs.append('{} × {} = ( {} ) \r\n'.format(i, j, i*j))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')
            for v in range(43, 46, 1):
                for i in range(75, 85, 1):
                    for j in range(31, 40, 1):
                        if (i - j == v):
                            subs.append('{} - {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')
            for v in range(38, 41, 1):
                for i in range(499, 77, -1):
                    for j in range(2, 30, 1):
                        if (i / j == v):
                            subs.append('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))

# testMath20170810()

def testMath20170822():
    try:
        fSub = open("/fff/tmp/oukings/math20170822-subject.txt", 'w')
        fAns = open("/fff/tmp/oukings/math20170822-answer.txt", 'w')
        if fSub != None:
            fSub.write('欧阳泓梓 - 20170822 - 数学题：\r\n')
            fAns.write('欧阳泓梓 - 20170822 - 数学题：\r\n')

            subs = []
            fSub.write('-- 以下是 加法 --\r\n')
            fAns.write('-- 以下是 加法 --\r\n')
            for v in range(91, 95, 1):
                for i in range(48, 58, 1):
                    for j in range(34, 44, 1):
                        if (i + j == v):
                            subs.append('{} + {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 乘法 --\r\n')
            fAns.write('-- 以下是 乘法 --\r\n')
            for i in range(47, 50, 1):
                for j in range(31, 40, 1):
                    subs.append('{} × {} = ( {} ) \r\n'.format(i, j, i*j))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 减法 --\r\n')
            fAns.write('-- 以下是 减法 --\r\n')
            for v in range(46, 49, 1):
                for i in range(78, 88, 1):
                    for j in range(31, 40, 1):
                        if (i - j == v):
                            subs.append('{} - {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            subs = []
            fSub.write('-- 以下是 除法 --\r\n')
            fAns.write('-- 以下是 除法 --\r\n')
            for v in range(41, 44, 1):
                for i in range(550, 83, -1):
                    for j in range(2, 30, 1):
                        if (i / j == v):
                            subs.append('{} ÷ {} = ( {} ) \r\n'.format(i, j, v))
            random.shuffle(subs)
            for sub in subs:
                fAns.write(sub)
                fSub.write(re.sub(r'\(.*\)', '( )', sub))

            fSub.close()
            fAns.close()
    except (IOError) as e:
        print((str(e)))

testMath20170822()
