#!/usr/bin/python3
import math

def is_odd(n):
    #return n % 2 == 1
    if n % 2 == 1:
        return n  
 
newlist = filter(is_odd, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
for i in newlist:
    print(i)

## 求1到100中平方根为证书的数
def is_sqr(x):
    return math.sqrt(x) % 1 == 0
 
newlist = filter(is_sqr, range(1, 101))
for i in newlist:
    print(i)


## 求0到9中能被2整除的数
a = filter(lambda x: x % 2 == 0, range(10)
for i in a:
    print(i)
    


