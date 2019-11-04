#!/usr/bin/env bash

# http://tldp.org/LDP/abs/html/arrays.html#ARRAYSTROPS
### 注意 注意 注意
# 1：数组下标可以是离散式
arr1=([0]="a b" [3]=2 [5]=4) # a b 2 4
# 2：${#arr1[@]}是指获取数组元素数量，不是数组长度
# 3：下标最小可以从0开始
# 4：echo ${arr1[@]:1:3} 指输出元素，是从第1个至第3个
# 5：@ 与 * 区别：* 当变量加上 “” 会当成一串字符串处理. @ 变量加上“”依然当做数组处理。在没有加上“”的情况下 效果是等效的.


# https://www.geeksforgeeks.org/array-basics-shell-scripting-set-1/
#1. Indirect Declaration
#In Indirect declaration, We assigned a value in a particular index of Array Variable. No need to first declare.
ARRAYNAME[INDEXNR]=value

#2. Explicit Declaration
#In Explicit Declaration, First We declare array then assigned the values.
declare -a ARRAYNAME

#3. Compound Assignment
#In Compount Assignment, We declare array with a bunch of values. We can add other values later too.
ARRAYNAME=(value1 value2  .... valueN)
#or
[indexnumber=]string
ARRAYNAME=([1]=10 [2]=20 [3]=30)

# To Print Array Value in Shell Script?
# To Print All elements
[@] & [*] means All elements of Array.
echo ${ARRAYNAME[*]}

# To declare static Array
arr=(prakhar ankit 1 rishabh manish abhinav)
# To print all elements of array
echo ${arr[@]}
echo ${arr[*]}
echo ${arr[@]:0}
echo ${arr[*]:0}
Output:
#prakhar ankit 1 rishabh manish abhinav
#prakhar ankit 1 rishabh manish abhinav
#prakhar ankit 1 rishabh manish abhinav
#prakhar ankit 1 rishabh manish abhinav

# To Print first element
echo ${arr[0]}
echo ${arr}
Output:
#prakhar
#prakhar

# To Print Selected index element
echo ${ARRAYNAME[INDEXNR]}

# To print particular element
echo ${arr[3]}
echo ${arr[1]}
Output:
#rishabh
#ankit

# To print elements from a particular index
echo ${ARRAYNAME[WHICH_ELEMENT]:STARTING_INDEX}

# To print elements from a particular index
echo ${arr[@]:0}
echo ${arr[@]:1}
echo ${arr[@]:2}
echo ${arr[0]:1}
Output:
#prakhar ankit 1 rishabh manish abhinav
#ankit 1 rishabh manish abhinav
#1 rishabh manish abhinav
#prakhar

# To print elements in range
echo ${ARRAYNAME[WHICH_ELEMENT]:STARTING_INDEX:COUNT_ELEMENT}

# To print elements in range
echo ${arr[@]:1:4}
echo ${arr[@]:2:3}
echo ${arr[0]:1:3}
Output:
#ankit 1 rishabh manish
#1 rishabh manish
#rak

# To count Length of in Array
# To count the length of a particular element in Array.
Use #(hash) to print length of particular element
# Length of Particular element
echo ${#arr[0]}
echo ${#arr}
Output:
#7
#7

# To count length of Array.
# Size of an Array
echo ${#arr[@]}
echo ${#arr[*]}
Output:
#6
#6

#To Search in Array
# arr[@] : All Array Elements.
# /Search_using_Regular_Expression/ : Search in Array
# Search Returns 1 if it found the pattern else it return zero. It does not alter the original array elements.
# Search in Array
echo ${arr[@]/*[aA]*/}
Output:
#1

#To Search & Replace in Array
# //Search_using_Regular_Expression/Replace : Search & Replace
# Search & Replace does not change in Original Value of Array Element. It just returned the new value. So you can store this value in same or different variable.
# Replacing Substring Temporary
echo ${arr[@]//a/A}
echo ${arr[@]}
echo ${arr[0]//r/R}
Output:
#prAkhAr Ankit 1 rishAbh mAnish AbhinAv
#prakhar ankit 1 rishabh manish abhinav
#RakhaR

#To delete Array Variable in Shell Script?
#To delete index-1 element
unset ARRAYNAME[1]
# To delete the whole Array
unset ARRAYNAME

#To add Array Variable in shell Script
#To append to tail fo Array
arr=([0]="a" [1]="b") # echo ${arr[@]} # a b
arr[${#arr[@]}]="c"   # echo ${arr[@]} # a b c

#To add
#To recreate Array 重新创建数组，可同时添加多个元素
array_name=("${array_name[@]}" value1 ... valueN)
# 注意1：首先，使用此方式添加元素后，数组中原有元素的下标会重置，会从0开始变成连续的，如果不希望改变下标则不能使用这种方式。
# 注意2：其次，双引号不能省略，否则，当数组array_name中存在包含空格的元素时会按空格将元素拆分成多个。
# 注意3：最后，不能将“@”替换为“*”，虽然在输出数组元素时可以相互替换，如果替换为“*”，不加双引号时与“@”的表现一致，加双引号时，
#       会将数组array_name中的所有元素作为一个元素添加到数组中。类似于特殊变量$@和$*的区别。

#To add
#扩建数，注意下标可以是离散式
arr1=([2]="a b" [3]=2 [5]=4) # a b 2 4
arr1+=(3 5) # 添加两个元素 # ${arr1[7]}的值就是5

# To declare static Array
arr=(prakhar ankit 1 rishabh manish abhinav)

# To print all elements of array
echo ${arr[@]}        # prakhar ankit 1 rishabh manish abhinav
echo ${arr[*]}        # prakhar ankit 1 rishabh manish abhinav
echo ${arr[@]:0}    # prakhar ankit 1 rishabh manish abhinav
echo ${arr[*]:0}    # prakhar ankit 1 rishabh manish abhinav

# To print first element
echo ${arr[0]}        # prakhar
echo ${arr}            # prakhar

# To print particular element
echo ${arr[3]}        # rishabh
echo ${arr[1]}        # ankit

# To print elements from a particular index
echo ${arr[@]:0}    # prakhar ankit 1 rishabh manish abhinav
echo ${arr[@]:1}    # ankit 1 rishabh manish abhinav
echo ${arr[@]:2}    # 1 rishabh manish abhinav
echo ${arr[0]:1}    # rakhar

# To print elements in range
echo ${arr[@]:1:4}    # ankit 1 rishabh manish
echo ${arr[@]:2:3}    # 1 rishabh manish
echo ${arr[0]:1:3}    # rak

# Length of Particular element
echo ${#arr[0]}        # 7
echo ${#arr}        # 7

# Size of an Array
echo ${#arr[@]}        # 6
echo ${#arr[*]}        # 6

# Search in Array
echo ${arr[@]/*[aA]*/}    # 1

# Replacing Substring Temporary
echo ${arr[@]//a/A}        # prAkhAr Ankit 1 rishAbh mAnish AbhinAv
echo ${arr[@]}            # prakhar ankit 1 rishabh manish abhinav
echo ${arr[0]//r/R}        # pRakhaR




# Substring Removal
# Removes shortest match from front of string(s).
echo ${arrayZ[@]#f*r}   # one two three five five
#               ^       # Applied to all elements of the array.
                        # Matches "four" and removes it.
# Longest match from front of string(s)
echo ${arrayZ[@]##t*e}  # one two four five five
#               ^^      # Applied to all elements of the array.
                        # Matches "three" and removes it.
# Shortest match from back of string(s)
echo ${arrayZ[@]%h*e}   # one two t four five five
#               ^       # Applied to all elements of the array.
                        # Matches "hree" and removes it.
# Longest match from back of string(s)
echo ${arrayZ[@]%%t*e}  # one two four five five
#               ^^      # Applied to all elements of the array.
                        # Matches "three" and removes it.
echo "----------------------"
# Substring Replacement
# Replace first occurrence of substring with replacement.
echo ${arrayZ[@]/fiv/XYZ}   # one two three four XYZe XYZe
#               ^           # Applied to all elements of the array.
# Replace all occurrences of substring.
echo ${arrayZ[@]//iv/YY}    # one two three four fYYe fYYe
                            # Applied to all elements of the array.
# Delete all occurrences of substring.
# Not specifing a replacement defaults to 'delete' ...
echo ${arrayZ[@]//fi/}      # one two three four ve ve
#               ^^          # Applied to all elements of the array.
# Replace front-end occurrences of substring.
echo ${arrayZ[@]/#fi/XY}    # one two three four XYve XYve
#                ^          # Applied to all elements of the array.
# Replace back-end occurrences of substring.
echo ${arrayZ[@]/%ve/ZZ}    # one two three four fiZZ fiZZ
#                ^          # Applied to all elements of the array.
echo ${arrayZ[@]/%o/XX}     # one twXX three four five five
#                ^          # Why?
echo "-----------------------------"