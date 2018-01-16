# http://www.runoob.com/w3cnote/python-yield-used-analysis.html
yield 类似return，但是只是在for等循环迭代的时候才真的执行。

#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
class Fab(object): 
 
    def __init__(self, max): 
        self.max = max 
        self.n, self.a, self.b = 0, 0, 1 
 
    def __iter__(self): 
        return self 
 
    def next(self): 
        if self.n < self.max: 
            r = self.b 
            self.a, self.b = self.b, self.a + self.b 
            self.n = self.n + 1 
            return r 
        raise StopIteration()
 
for n in Fab(5): 
    print n

#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
def fab(max): 
    n, a, b = 0, 0, 1 
    while n < max: 
        yield b      # 使用 yield
        # print b 
        a, b = b, a + b 
        n = n + 1
 
for n in fab(5): 
    print n
  

=========
def fib(max):
    n,a,b = 0,0,1
    c = []
    while n < max:
        c.append(a)
        a,b=b,a+b
        n = n +1 
    return c

print(fib(10))


d = [x*x for x in range(10)]
print(d)


for i in (x*x for x in range(10))
    print(i)

def read_file(fpath): 
    BLOCK_SIZE = 1024 
    with open(fpath, 'rb') as f: 
        while True: 
            block = f.read(BLOCK_SIZE) 
            if block: 
                yield block 
            else: 
                return
