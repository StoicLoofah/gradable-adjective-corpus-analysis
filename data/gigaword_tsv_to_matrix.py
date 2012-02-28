adjs = [line.rstrip('\n') for line in open('adj-small.txt', 'r').readlines()]
adj_to_index = dict(zip(adjs, range(len(adjs))))
adj_unigram_count = [0] * len(adjs)

mods = [line.rstrip('\n') for line in open('mod-small.txt', 'r').readlines()]
mod_to_index = dict(zip(mods, range(len(mods))))
mod_unigram_count = [0] * len(mods)

dep = [[0] * len(mods) for x in xrange(len(adjs))]

for line in open('gigawordnyt-advmod.tsv', 'r'):
    words = line.rstrip('\n').split('\t')

    mod_index = mod_to_index.get(words[1], -1)
    adj_index = adj_to_index.get(words[0], -1)
    count = int(words[2])

    if adj_index != -1:
        adj_unigram_count[adj_index] += count

    if mod_index != -1:
        mod_unigram_count[mod_index] += count

    if adj_index != -1 and mod_index != -1:
        dep[adj_index][mod_index] += count

print('ADJECTIVES')
for c in adj_unigram_count:
    print(c)

print('MODIFIERS')
for c in mod_unigram_count:
    print(c)

print('DEPENDENCIES')
for row in dep:
    print(row)
