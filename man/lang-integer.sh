#!/usr/bin/env bash

# 数值处理
#(1) let命令
#(2) shell扩展$(( expression ))
#(3) expr命令

A=3
B=$((100 * $A + 5)) # 305

# The basic operators are:
a + b  # addition (a plus b)

a - b  # substraction (a minus b)

a * b  # multiplication (a times b)

a / b  # division (integer) (a divided by b)

a % b  # modulo (the integer remainder of a divided by b)

a ** b # exponentiation (a to the power of b)


#comparison    Evaluated to true when
$a -lt $b    $a < $b
$a -gt $b    $a > $b
$a -le $b    $a <= $b
$a -ge $b    $a >= $b
$a -eq $b    $a is equal to $b
$a -ne $b    $a is not equal to $b


### [] test
# test和[]中可用的比较运算符只有==和!=，两者都是用于字符串比较的，
# 不可用于整数比较，整数比较只能使用-eq，-gt这种形式