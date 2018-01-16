#!/usr/bin/env python3

import json

class Student(object):
    def __init__(self, name, age, score):
        self.name = name
        self.age = age
        self.score = score

def student2dict(std):
    return {
        'name': std.name,
        'age': std.age,
        'score': std.score
    }

s = Student('Bob', 20, 88)
print(json.dumps(student2dict(s)))
print(json.dumps(s,default=lambda obj:obj.__dict__))


##  之 所以无法把Student类实例序列化为JSON，是因为默认情况下，dumps()方法不知道如何将Student实例变为一个JSON的{}对象。

## 可选参数default就是把任意一个对象变成一个可序列为JSON的对象


json_str = '{"age": 20, "score": 88, "name": "Bob"}'
json.loads(json_str)

