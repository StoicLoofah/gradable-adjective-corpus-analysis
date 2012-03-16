stim_num_to_indices = {}
f = open("stimuli_indices.csv", 'r')
count = 0
for line in f:
	vals = line.rstrip('\n').split(',')
	stim_num_to_indices[count] = [int(vals[0]), int(vals[1])]
	count += 1
f.close()

f = open("indices.csv", 'r')
indices = []
for line in f:
	indices.append(line.rstrip('\n').split(','))
f.close()

f = open("ratings.csv", 'r')
ratings = []
for line in f:
	ratings.append(line.rstrip('\n').split(','))
f.close()

folder = '../../../data/word_sets/kennedy/'
adjs = [line.rstrip('\n') for line in open(folder + 'adj.txt', 'r').readlines()]
mods = [line.rstrip('\n') for line in open(folder + 'mod.txt', 'r').readlines()]
adj_class = [line.rstrip('\n') for line in open(folder + 'adj_class.txt', 'r').readlines()]
mod_class = [line.rstrip('\n') for line in open(folder + 'mod_class.txt', 'r').readlines()]
adj_class_indices = [line.rstrip('\n') for line in open('../../../data/adj_classes.txt', 'r').readlines()]
mod_class_indices = [line.rstrip('\n') for line in open('../../../data/mod_classes.txt', 'r').readlines()]

fout = open('individual_trials.csv', 'w')
fout_nums = open('individual_trials_nums_only.csv', 'w')
fout.write('subject id, stim id, adj, adj id, adj class, adj class id, mod, mod id, mod class, mod class id, rating\n')
fout_nums.write('subject, stim id, adj, adj class, mod, mod class, rating\n')
for i in range(len(indices)):
	for j in range(len(indices[0])):
		cur_indices = stim_num_to_indices[int(indices[i][j])]
		cur_val = int(ratings[i][j])
		adj_index = cur_indices[0]
		mod_index = cur_indices[1]
		fout.write('{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10}\n'.format(i, indices[i][j], adjs[adj_index], adj_index, adj_class[adj_index], adj_class_indices.index(adj_class[adj_index]), mods[mod_index], mod_index, mod_class[mod_index], mod_class_indices.index(mod_class[mod_index]), cur_val))
		fout_nums.write('{0},{1},{2},{3},{4},{5},{6}\n'.format(i, indices[i][j], adj_index,  adj_class_indices.index(adj_class[adj_index]), mod_index, mod_class_indices.index(mod_class[mod_index]), cur_val))
		
fout.close()
fout_nums.close()