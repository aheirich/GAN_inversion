
#!/usr/bin/python3

import sys

width = 25
height = 25
depth = 32

data = []
lineCounter = 1
columnCounter = 0

assert len(sys.argv) == 3
file = open(sys.argv[1])
variable = sys.argv[2]

print('param ' + variable + ' :=')

counter = 1
for line in file:
  words = line.strip().split(' ')
  for word in words:
    while word.startswith('['): word = word[1:]
    while word.endswith(']'): word = word[:-1]
    try:
      value = float(word)
      print(counter, value)
      counter = counter + 1
  
    except ValueError:
      pass

print(';')
