from math import *

def magnitude(a):
    return sqrt(sum(x * x for x in a))

bigrams_in = open('gw-bigrams-small-vector.csv').readline().rstrip('\n')
dep_in = open('gw-dep-small-vector.csv').readline().rstrip('\n')

bigrams = map(int, bigrams_in.split(','))
dep = map(int, dep_in.split(','))

num = sum(x * y for (x, y) in zip(bigrams, dep)) 

denom = magnitude(bigrams) * magnitude(dep)

print(float(num) / denom)
