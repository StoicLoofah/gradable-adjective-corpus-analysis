adjs = [line.rstrip('\n') for line in open('adj-small.txt', 'r').readlines()]
adj_to_index = dict(zip(adjs, range(len(adjs))))
adj_unigram_count = [0] * len(adjs)

mods = [line.rstrip('\n') for line in open('mod-small.txt', 'r').readlines()]
mod_to_index = dict(zip(mods, range(len(mods))))
mod_unigram_count = [0] * len(mods)

for line in open('all_adj_unigram.txt', 'r'):
    adj = line.rstrip('\n')
    if adj in adj_to_index:
        adj_unigram_count[adj_to_index[adj]] += 1

print('ADJECTIVES')
for c in adj_unigram_count:
    print(c)

for line in open('all_mod_unigram.txt', 'r'):
    mod = line.rstrip('\n')
    if mod in mod_to_index:
        mod_unigram_count[mod_to_index[mod]] += 1

print('MODIFIERS')
for c in mod_unigram_count:
    print(c)
        
bigrams = [[0] * len(mods) for x in xrange(len(adjs))]

for line in open('all_bigrams.txt', 'r'):
    words = line.rstrip('\n').split(' ')
    mod_index = mod_to_index.get(words[0], -1)
    adj_index = adj_to_index.get(words[1], -1)
    if adj_index != -1 and mod_index != -1:
        bigrams[adj_index][mod_index] += 1

print('BIGRAMS')
for row in bigrams:
    print(row)

dep = [[0] * len(mods) for x in xrange(len(adjs))]
for line in open('all_dep.txt', 'r'):
    words = line.rstrip('\n').split(' ')
    mod_index = mod_to_index.get(words[0], -1)
    adj_index = adj_to_index.get(words[1], -1)
    if adj_index != -1 and mod_index != -1:
        dep[adj_index][mod_index] += 1

print('DEPENDENCIES')
for row in dep:
    print(row)
