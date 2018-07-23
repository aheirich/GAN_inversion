#!/usr/bin/python3

import sys

numFilters = 16
filterWidth = 8
filterHeight = 3
filterDepth = 2

filterCount = 1
heightCount = 1
depthCount = 1

print("# input layer\n")
print("param weight_1 :=")

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

  if len(words) < filterWidth: continue
  assert len(words) == filterWidth

  if heightCount == 1:
    print('')
    print("[*, *, " + str(depthCount) + ", " + str(filterCount) + "] : 1 2 3 4 5 6 7 8 :=")
  print(str(heightCount) + ' ' + words[0] + ' ' + words[1] + ' ' + words[2] + ' ' + words[3] + ' ' + words[4] + ' ' + words[5] + ' ' + words[6] + ' ' + words[7])
  words = []

  if heightCount == 1:
    depthCount = depthCount + 1
    if depthCount > filterDepth:
      depthCount = 1
      filterCount = filterCount + 1

  heightCount = heightCount + 1
  if heightCount > filterHeight: heightCount = 1

print(";\n")

