#!/usr/bin/python3

import sys

width = 50
height = 50
depth = 16

data = []
lineCounter = 1
columnCounter = 0
file = open(sys.argv[1])
for line in file:
  words = line.strip().split(' ')
  for word in words:
    while word.startswith('['): word = word[1:]
    while word.endswith(']'): word = word[:-1]
    try:
      value = float(word)
      data.append(word)
      if len(data) == depth:
        if columnCounter == 0:
          string = 'param Z1[' + str(lineCounter) + ', *, *] :='
          lineCounter = lineCounter + 1
          for i in range(depth): string = string + ' ' + str(i + 1)
          string = string + ' :='
          print('')
          print(string)
        string = str(columnCounter + 1)
        columnCounter = (columnCounter + 1) % width
        for word in data:
          string = string + ' ' + word
        print(string)
        data = []

    except ValueError:
      pass

print(';')
