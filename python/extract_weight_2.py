#!/usr/bin/python3

import sys

numFilters = 32
filterWidth = 3
filterHeight = 8
filterDepth = 16

filterCount = 1
heightCount = 1
depthCount = 1

lineCount = 0

print("w2 = [")

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

    data = str(words[0]) + ', ' + str(words[1]]) + ', ' + str(words[2])
    if lineCount % filterHeight == 0:
        print('[[', data, '],')
    elif lineCount % filterHeight == filterHeight - 1:
        print('[', data, ']],')
    else:
        print('[', str(words[0]) + ', ', ])


print("]")
