person = {
    'first': 'Tobin',
    'age':20
}

print('{first} is {age} years old'.format(**person))
# Output: Tobin is 20 years old

person = {
    'first':'Tobin',
    'last': 'Brown',
    'age':20
}
print('{first} {last} is {age} years old'.format(**person))
