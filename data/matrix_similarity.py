from math import *

def magnitude(a):
    return sqrt(sum(x * x for x in a))

gigaword_nyt_dep = 'gigaword_nyt_dep/gw-dep-small-vector.csv'
gigaword_slice_dep = 'gigaword_slice/gw-dep-small-vector.csv'
gigaword_slice_bigrams = 'gigaword_slice/gw-bigrams-small-vector.csv'
web1t = 'web1t/web1t-bigrams-small-vector.csv'

bigrams_in = open(gigaword_slice_dep).readline().rstrip('\n')
dep_in = open(gigaword_nyt_dep).readline().rstrip('\n')

bigrams = map(int, bigrams_in.split(','))
dep = map(int, dep_in.split(','))

num = sum(x * y for (x, y) in zip(bigrams, dep)) 

denom = magnitude(bigrams) * magnitude(dep)

print(float(num) / denom)
