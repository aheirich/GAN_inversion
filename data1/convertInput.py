#!/usr/bin/python

import sys

data = []
file = open(sys.argv[1])
for line in file:
  words = line.split(' ')
  values = []
  for word in words:
    values.append(float(word))
  data.append(values)

padding_height = 4
padding_width = 2

feature = data[:-1]
label = data[-1]

for i in range(padding_height):
  out = ''
  for j in range(len(label) * 2 + 2 * padding_width):
    out = out + '0 '
  print(out)

for line in feature:
  out = ''
  for j in range(padding_width):
    out = out + '0 '
  for n in line:
    out = out + str(n) + ' '
  for n in label:
    out = out + str(n) + ' '
  for j in range(padding_width):
    out = out + '0 '
  print(out)

for i in range(padding_height):
  out = ''
  for j in range(len(label) + 2 * padding_width):
    out = out + '0 '
  print(out)
