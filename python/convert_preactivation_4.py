
#!/usr/bin/python3

import sys

data = []
size = 1

assert len(sys.argv) == 2
file = open(sys.argv[1])

for line in file:
  words = line.strip().split(' ')
  for word in words:
    while word.startswith('['): word = word[1:]
    while word.endswith(']'): word = word[:-1]
    try:
      value = float(word)
      data.append(word)
    except ValueError:
      pass

string = 'param a4_ :'
for i in range(size): string = string + ' ' + str(i + 1)
string = string + ' :='
print(string)

line = 1
for datum in data:
  print(line, datum)
  line = line + 1

print(';')
