

matrix = [[0] * 14 for i in range(49)]
counts = [[0] * 14 for i in range(49)]

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
		matrix[cur_indices[0]][cur_indices[1]] += cur_val
		counts[cur_indices[0]][cur_indices[1]] += 1
		
for i in range(len(matrix)):
	for j in range(len(matrix[0])):
		matrix[i][j] = matrix[i][j] / counts[i][j]
		
fout = open('rating_matrix.csv', 'w')
for row in matrix:
	for col in row:
		fout.write(str(col) + ',')
	fout.write('\n')
fout.close()
