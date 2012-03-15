import string
import random
import math

short_list = True
num_stimuli = 100

folder = '../../data/word_sets/kennedy_extended/'
adj_file = folder + 'adj.txt'
mod_file = folder + 'mod.txt'
adjs = [line.rstrip('\n') for line in open(adj_file, 'r').readlines()]
mods = [line.rstrip('\n') for line in open(mod_file, 'r').readlines()]

lines = [line.rstrip('\n') for line in open('experiment_1/stimuli.txt', 'r').readlines()]

fout = open('indices.csv', 'w')

for line in lines:
	words = line.split(' ')
	mod = mods.index(words[0].lstrip()) + 1
	adj = adjs.index(words[1].lstrip()) + 1
	fout.write('{0},{1}\n'.format(adj, mod))
	
fout.close()

