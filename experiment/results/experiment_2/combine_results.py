"""
Calculate mean and standard deviation of data x[]:
    mean = {\sum_i x_i \over n}
    std = sqrt(\sum_i (x_i - mean)^2 \over n-1)
"""
def meanstdv(x):
    from math import sqrt
    n, mean, std = len(x), 0, 0
    for a in x:
	mean = mean + a
    mean = mean / float(n)
    for a in x:
	std = std + (a - mean)**2
    std = sqrt(std / float(n-1))
    return mean, std


ratings_separated = []
for i in range(49):
	temp = [[] for i in range(14)]
	ratings_separated.append(temp)

means = [[0] * 14 for i in range(49)]
stdev = [[0] * 14 for i in range(49)]

stim_num_to_indices = {}
f = open("stimuli_indices.csv", 'r')
count = 0
for line in f:
	vals = line.split(',')
	stim_num_to_indices[count] = [int(vals[0]), int(vals[1])]
	count += 1
f.close()

f = open("indices.csv", 'r')
indices = []
for line in f:
	indices.append(line.split(','))
f.close()

f = open("zscored.csv", 'r')
ratings = []
for line in f:
	ratings.append(line.split(','))
f.close()

for i in range(len(indices)):
	for j in range(len(indices[0])):
		cur_indices = stim_num_to_indices[int(indices[i][j])]
		cur_val = float(ratings[i][j])
		ratings_separated[cur_indices[0]][cur_indices[1]].append(cur_val)
		
for i in range(len(ratings_separated)):
	for j in range(len(ratings_separated[0])):
		[means[i][j], stdev[i][j]] = meanstdv(ratings_separated[i][j])
		
fout = open('rating_matrix_means.csv', 'w')
for row in means:
	for col in row:
		fout.write(str(col) + ',')
	fout.write('\n')
fout.close()

fout = open('rating_matrix_stdev.csv', 'w')
for row in stdev:
	for col in row:
		fout.write(str(col) + ',')
	fout.write('\n')
fout.close()