f = open("parseable.csv", 'r')

indices = []
ratings = []

for line in f:
	split = line.split(',')
	cur_indices = []
	cur_ratings = []
	for temp in split:
		temp = temp.lstrip().rstrip()
		if temp.find('[') == -1:
			continue
		temp = temp[1:-1]
		split2 = temp.split('$')
		if split2[0][0] == '-':
			continue
		cur_indices.append(split2[0])
		cur_ratings.append(split2[1])
	indices.append(cur_indices)
	ratings.append(cur_ratings)
	
f.close()

length = len(indices[0])

fout_indices = open('indices.csv', 'w')
for row in indices:
	assert len(row) == length
	fout_indices.write(','.join(row) + '\n')
fout_indices.close()
		
fout_ratings = open('ratings.csv', 'w')
for row in ratings:
	assert len(row) == length
	fout_ratings.write(','.join(row) + '\n')
fout_ratings.close()
