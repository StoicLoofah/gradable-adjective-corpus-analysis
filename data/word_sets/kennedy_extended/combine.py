adj1 = [line.rstrip('\n') for line in open('mod.txt', 'r').readlines()]
adj2 = [line.rstrip('\n') for line in open('mod-small.txt', 'r').readlines()]

adjs = adj1 + adj2
vals = set(adjs)

final_adj = sorted(list(vals))

for adj in final_adj:
	print adj