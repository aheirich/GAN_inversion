#!/usr/bin/python3

import sys

print("# output layer\n")
print("param weight_4 :=")

words = []
for line in sys.stdin:
  allWords = line.strip().split(' ')
  for word in allWords:
    while word.startswith('['): word = word[1:]
    while word.endswith(']'): word = word[:-1]
    try:
      w = float(word)
      words.append(word.strip())
    except ValueError:
      pass

counter = 1
for word in words:
  print(str(counter) + ' ' + word)
  counter = counter + 1
print(';')
