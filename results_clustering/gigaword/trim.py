
adj = set(map(lambda a: a.rstrip('\n'), open('adj-small.txt', 'r').readlines()))
mod = set(map(lambda a: a.rstrip('\n'), open('mod-small.txt', 'r').readlines()))

bigrams = map(lambda a: a.rstrip('\n'), open('ltw_eng_199506_dep.txt', 'r').readlines())
for bigram in bigrams:
    words = bigram.split(' ')
    if words[0] in mod and words[1] in adj:
        print(bigram)
