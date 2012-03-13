folder = 'word_sets/kennedy/'
adj_file = folder + 'adj.txt'
mod_file = folder + 'mod.txt'

adjs = [line.rstrip('\n') for line in open(adj_file, 'r').readlines()]
adj_to_index = dict(zip(adjs, range(len(adjs))))
adj_unigram_count = [0] * len(adjs)

mods = [line.rstrip('\n') for line in open(mod_file, 'r').readlines()]
mod_to_index = dict(zip(mods, range(len(mods))))
mod_unigram_count = [0] * len(mods)

dep = [[0] * len(mods) for x in xrange(len(adjs))]

total = 0

for line in open('gigawordnyt-advmod.tsv', 'r'):
	words = line.rstrip('\n').split('\t')

	mod_index = mod_to_index.get(words[1], -1)
	adj_index = adj_to_index.get(words[0], -1)
	count = int(words[2])

	total += count

	if adj_index != -1:
		adj_unigram_count[adj_index] += count

	if mod_index != -1:
		mod_unigram_count[mod_index] += count

	if adj_index != -1 and mod_index != -1:
		dep[adj_index][mod_index] += count

fout = open(folder + 'adj-unigram.csv', 'w')
for c in adj_unigram_count:
	fout.write(str(c) + '\n')
fout.close()

fout = open(folder + 'mod-unigram.csv', 'w')
for c in mod_unigram_count:
	fout.write(str(c) + '\n');
fout.close()

fout = open(folder + 'matrix.csv', 'w')
for row in dep:
	fout.write(str(row) + '\n')
fout.close()

fout = open(folder + 'total.txt', 'w')
fout.write(str(total) + '\n')
fout.close()