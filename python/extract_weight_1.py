#!/usr/bin/python3

import sys

numFilters = 16
filterWidth = 8
filterHeight = 3
filterDepth = 2

filterCount = 1
heightCount = 1
depthCount = 1

count = 0

print('w1 = [')
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

    if count % (filterHeight * filterDepth) == 0: print('[')
    comma = ','
    if count % filterHeight == filterHeight - 1: comma = ''
    if count % filterHeight == 0: print('[')
    print('[ ' + words[0] + ', ' + words[1] + ', ' + words[2] + ', ' + words[3] + ', ' + words[4] + ', ' + words[5] + ', ' + words[6] + ', ' + words[7] + ' ]' + comma)
    comma2 = ','
    if count % (filterHeight * filterDepth) == (filterHeight * filterDepth - 1): comma2 = ''
    if count % filterHeight == filterHeight - 1: print(']' + comma2)
    if count % (filterHeight * filterDepth) == (filterHeight * filterDepth - 1): print('],')
    count = count + 1

    words = []
print(']')
