#!/usr/bin/python3

import sys

width = 100
height = 100
z = 0
data = [[], []]

file = open(sys.argv[1])
for line in file:
  words = line.strip().split(' ')
  for word in words:
    while word.startswith('['): word = word[1:]
    while word.endswith(']'): word = word[:-1]
    try:
      value = float(word)
      data[z].append(word)
      z = (z + 1) % 2
    except ValueError:
      pass
    

# must match ampl model parameters padding_height_0, padding_width_0
padding_height = 5
padding_width = 5

assert len(data[0]) == width * height
assert len(data[1]) == width * height

def printLayer(z):
  effectiveWidth = width + 2 * padding_width

#  string = '[*,*,' + str(z + 1) + '] : '
#  for i in range(effectiveWidth): string = string + str(i + 1) + ' '
#  string = string + ':='
#  print(string)

  for i in range(padding_height):
    string = ''
    for j in range(effectiveWidth - 1): string = string + ' 0,'
    string = string + ' 0'
    print('[' + string + '],')

  index = 0
  for i in range(height):
#    string = str(i + 1 + padding_height)
    string = ''
    for j in range(padding_width): string = string + ' 0,'
    for j in range(width):
      string = string + ' ' + str(data[z][index]) + ', '
      index = index + 1
    for j in range(padding_width - 1): string = string + ' 0,'
    string = string + ' 0'
    print('[' + string + '],')

  for i in range(padding_height):
    string = ''
    for j in range(effectiveWidth - 1): string = string + ' 0,'
    string = string + ' 0'
    print('[' + string + '5')

print('x = [')
print('[')
printLayer(0)
print('],')
print('[')
printLayer(1)
print(']]')

