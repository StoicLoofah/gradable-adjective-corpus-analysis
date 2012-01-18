f = open('gold-gradable.csv', 'r')
clusters = {}

for line in f:
    split = line.split(',')
    if split[1] in clusters:
        clusters[split[1]].append(split[0])
    else:
        clusters[split[1]] = [split[0]]

f.close()

gold_assn = {}
for i, cluster in enumerate(clusters.values()):
    for word in cluster:
        gold_assn[word] = i

filenames = ['1cluster.csv', 'random3.csv', 'random4.csv', 'random5.csv', 'random6.csv', 'random7.csv', 'random8.csv', ]

for filename in filenames:

    f = open(filename)
    model_assn = {}
    i = 0
    for line in f:
        split = line[0:-1].split(',')
        for word in split:
            if word:
                model_assn[word] = i
        i += 1

    tp = 0
    tn = 0
    fp = 0
    fn = 0
    words = gold_assn.keys()
    for i, word1 in enumerate(words):
        for word2 in words[(i + 1):]:
            if gold_assn[word1] == gold_assn[word2]:
                if model_assn[word1] == model_assn[word2]:
                    tp += 1
                else:
                    fn += 1
            else:
                if model_assn[word1] == model_assn[word2]:
                    fp += 1
                else:
                    tn += 1

    rand_index = (tp + tn) / float(tp + tn + fp + fn)

    p = tp / float(tp + fp)
    r = tp / float(tp + fn)
    beta = 5
    f = ((beta * beta + 1) * p * r) / float(beta * beta * p + r)

    print(filename)
    print('rand index: ' + str(rand_index))
    print('f score: ' + str(f))
    print('')
