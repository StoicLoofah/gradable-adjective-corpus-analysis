adjs = [line.rstrip('\n') for line in open('adj-small.txt', 'r').readlines()]
adjs_gradable = [line.rstrip('\n') for line in open('adj-gradable-unsorted.txt', 'r').readlines()]

unigrams = [line.rstrip('\n') for line in open('adj-unigram-small.csv', 'r').readlines()]
bigrams = [line.rstrip('\n') for line in open('web1t-bigrams-small-nolabels.csv', 'r').readlines()]
ooe = [line.rstrip('\n') for line in open('web1t-ooe-small-nolabel.csv', 'r').readlines()]

fout = open('adj-gradable.txt', 'w')
for i, adj in enumerate(adjs):
    if adj in adjs_gradable:
        fout.write(adj + '\n')
fout.close()

fout = open('adj-unigram-gradable.csv', 'w')
for i, adj in enumerate(adjs):
    if adj in adjs_gradable:
        fout.write(unigrams[i] + '\n')
fout.close()

fout = open('web1t-bigrams-gradable.csv', 'w')
for i, adj in enumerate(adjs):
    if adj in adjs_gradable:
        fout.write(bigrams[i] + '\n')
fout.close()        

fout = open('web1t-ooe-gradable.csv', 'w')
for i, adj in enumerate(adjs):
    if adj in adjs_gradable:
        fout.write(ooe[i] + '\n')
fout.close()
