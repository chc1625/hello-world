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
    
## 排序
s = sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower, reverse=True)
print(s)

           
## 对tuple排序
L = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]
def getKey(item):
    return item[0]
s = sorted(L,key = getKey)
print(s)

           

           
## Python 有办法将任意值转为字符串：将它传入repr() 或str() 函数。

## 函数str() 用于将值转化为适于人阅读的形式，而repr() 转化为供解释器读取的形式。
dict1 = {'runoob': 'runoob.com', 'google': 'google.com'};
print(repr(dict1))
           

