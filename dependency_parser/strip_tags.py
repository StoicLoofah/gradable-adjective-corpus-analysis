fin = open('nyt_eng_199407', 'r')
fout = open('nyt.out', 'w')

next = False
for line in fin:
    if line.startswith('</P>'):
        next = False
    if next:
        fout.write(line)
        next = False
    if line.startswith('<P>'):
        next = True

fin.close()
fout.close()


