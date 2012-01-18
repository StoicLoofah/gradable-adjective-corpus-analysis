import random

adjs = [line.rstrip('\n') for line in open('adj-gradable.txt', 'r').readlines()]

for nClusters in range(3, 9):
    fout = open('random{0}.csv'.format(nClusters), 'w')

    clusters = [[] for i in xrange(nClusters)]

    for adj in adjs:
        clusters[random.randint(0, nClusters - 1)].append(adj)

    for cluster in clusters:
        for word in cluster:
            fout.write(word + ',')
        fout.write('\n')
    fout.close()
