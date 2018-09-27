#!/usr/bin/python3

import sys

width = 50
height = 50
depth = 16

data = []
lineCounter = 0

assert len(sys.argv) == 2
file = open(sys.argv[1])

print('z1 = [')

for line in file:
    words = line.strip().split(' ')
    for word in words:
        while word.startswith('['): word = word[1:]
        while word.endswith(']'): word = word[:-1]
        try:
            value = float(word)
            data.append(word)
            if len(data) == depth:
                string = ''
                for word in data[0:-1]:
                    string = string + word + ', '
                string = string + data[-1]
                if lineCounter % width == 0: print('[')
                lineCounter = lineCounter + 1
                if lineCounter % width == 0:
                    print('[ ' + string + ']],')
                else: print('[ ' + string + '],')
                data = []

        except ValueError:
            pass

print(']')
