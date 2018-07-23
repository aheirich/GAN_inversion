#!/usr/bin/python3

import sys

numFilters = 32
filterWidth = 3
filterHeight = 8
filterDepth = 16

filterCount = 1
heightCount = 1
depthCount = 1

print("param weight_2 :=")

for line in sys.stdin:
  allWords = line.strip().split(' ')
  words = []
  for word in allWords:
    if word != '':
      words.append(word)
  if len(words) < 3:
    continue
  if words[0] == '[' or words[0] == '[[':
    words = words[1:]
  while words[0].startswith('['):
    words[0] = words[0][1:]
  if words[-1] == ']' or words[-1] == ']]':
    words = words[:-1]
  while words[-1][-1] == ']':
    words[-1] = words[-1][:-1]
  if len(words) != 3:
    print('line not 3', line)
    print('words not 3', words)
  assert len(words) == 3

  if heightCount == 1:
    print("[*, *, " + str(depthCount) + ", " + str(filterCount) + "] : 1 2 3 :=")
  print(str(heightCount) + ' ' + words[0] + ' ' + words[1] + ' ' + words[2])

  if heightCount == 1:
    depthCount = depthCount + 1
    if depthCount > filterDepth:
      depthCount = 1
      filterCount = filterCount + 1

  heightCount = heightCount + 1
  if heightCount > filterHeight: heightCount = 1

print(";\n")
