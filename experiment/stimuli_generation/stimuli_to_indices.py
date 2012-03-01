import string
import random
import math

short_list = True
num_stimuli = 100

short_adjs = [line.rstrip('\n') for line in open('adj-small2.txt', 'r').readlines()]
short_mods = [line.rstrip('\n') for line in open('mod-small2.txt', 'r').readlines()]

lines = [line.rstrip('\n') for line in open('stimuli.txt', 'r').readlines()]

fout = open('indices.csv', 'w')

for line in lines:
	words = line.split(' ')
	mod = short_mods.index(words[0])
	adj = short_adjs.index(words[1])
	fout.write('{0},{1}\n'.format(adj, mod))
	
fout.close()

